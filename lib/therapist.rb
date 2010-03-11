require 'git'
require 'net/http'
require 'thor'
require 'yaml'
require 'pathname'

class Therapist < Thor
  no_tasks do
    attr_accessor :username, :repository
  end

  def initialize(args = [], options={}, config={})
    git = Git.open(Dir.pwd)

    origin_url = git.remote('origin').url
    origin_url =~ /git@github\.com:(.*)\/(.*)\.git/
    @username = $1
    @repository = $2

    @out = $stdout

    super
  end


  desc "list", "Lists issues for the current repository"
  def list
    fetch_issues unless File.exist?(open_issues_file)

    open_issues.each do |issue|
      @out.puts "##{issue['number'].to_s.ljust 3} #{issue['state'].rjust 6}: #{issue['title']}"
    end
  end

  desc "show NUMBER", "Shows a specific issue for the current repository"
  def show(number)
    number.gsub!('#', '')
    fetch_issue(number) unless issue_file(number).exist?

    issue = YAML.load(issue_file(number).read)['issue']

    @out.puts "##{issue['number']} #{issue['state']}: #{issue['title']}"
    @out.puts
    @out.puts "user   : #{issue['user']}"
    @out.puts "created: #{issue['created_at']}"
    @out.puts "updated: #{issue['updated_at']}"
    @out.puts "votes  : #{issue['votes']}"
    @out.puts
    @out.puts issue['body']
  end

  desc "fetch", "Fetches issues for the current repository"
  def fetch
    fetch_issues
  end

  private

  def open_issues
    YAML.load(open_issues_file.read)['issues']
  end


  def fetch_issues
    FileUtils.mkdir_p(issues_dir)

    response = Net::HTTP.get(URI.parse(list_issues_url))

    File.open open_issues_file, "w" do |file|
      file.write response
    end

    open_issues.each do |issue|
      fetch_issue(issue['number'])
    end
  end

  def fetch_issue(number)
    FileUtils.mkdir_p(issues_dir)
    response = Net::HTTP.get(URI.parse(show_issue_url(number)))

    File.open issue_file(number), "w" do |file|
      file.write response
    end
  end

  def issues_dir
    @issues_dir ||= Pathname.new('.git/issues')
  end

  def show_issue_url(number)
    "http://github.com/api/v2/yaml/issues/show/#{username}/#{repository}/#{number}"
  end

  def list_issues_url
    "http://github.com/api/v2/yaml/issues/list/#{username}/#{repository}/open"
  end

  def open_issues_file
    @open_issues_file ||= issues_dir.join('open.yml')
  end

  def issue_file(number)
    issues_dir.join("#{number}.yml")
  end

end
