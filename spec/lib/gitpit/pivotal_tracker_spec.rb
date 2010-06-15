require "spec_helper"

describe Gitpit::PivotalTracker do
  before :all do
    Gitpit::PivotalTracker.mode = :production
  end
  
  def should_request(path, http_result = 200, response_body = "spec/support/responses/#{path}.xml")
    ::PivotalTracker::Client.connection.should_receive(:[]).at_least(:once).with(path).and_return do
      resource = mock(path)
      resource.stub!(:get).and_return do
        RestClient::Response.new(IO.read(Rails.root.join(response_body)), http_result, nil)
      end
      resource
    end
    
    ::PivotalTracker::Client.connection["/projects"].get
  end
  
  it "uses an existing token" do
    ::PivotalTracker::Client.should_receive(:token=).with("abcdef")
    Gitpit::PivotalTracker.token = "abcdef"
  end
  
  it "logs in a user with password" do
    ::PivotalTracker::Client.should_receive(:token).with("username", "password").and_return("abcdef")
    Gitpit::PivotalTracker.login("username", "password").should == "abcdef"
  end
  
  it "logs out a user" do
    ::PivotalTracker::Client.should_receive(:token=).with("abcdef")
    ::PivotalTracker::Client.should_receive(:token=).with(nil)
    
    Gitpit::PivotalTracker.token = "abcdef"
    Gitpit::PivotalTracker.logout
  end
  
  it "returns a unique list of the active projects' account names" do
    should_request("/projects")
    
    Gitpit::PivotalTracker.account_names.should == ["Pet Projects", "Secret Sauce Partners"]
  end
  
  it "returns the overall velocity of all projects under an account" do
    should_request("/projects")
    
    Gitpit::PivotalTracker.overall_velocity("Secret Sauce Partners").should == 7
  end
  
  it "returns the current stories of all projects under an account" do
    should_request("/projects")
    should_request("projects/1/iterations/current")
    should_request("projects/3/iterations/current")

    current_stories = Gitpit::PivotalTracker.current_stories("Secret Sauce Partners")
    current_stories.count.should == 2
  end  
end
