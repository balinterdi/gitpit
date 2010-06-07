require "spec_helper"

describe Gitpit::PivotalTracker do
  before :all do
    Gitpit::PivotalTracker.mode = :production
  end
  
  def should_request(path, response_body = "spec/support/responses#{path}.xml", http_result = 200)
    ::PivotalTracker::Client.connection.should_receive(:[]).with(path).and_return do |path|
      resource = mock(path)
      resource.stub!(:get).and_return(RestClient::Response.new(IO.read(Rails.root.join(response_body)), http_result, nil))
      resource
    end
    
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
  
end
