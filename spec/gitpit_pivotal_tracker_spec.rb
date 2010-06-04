require "spec_helper"

describe GitPit::PivotalTracker do
  before :all do
    GitPit::PivotalTracker.mode = :production
  end
  
  def new_project(name)
    project = ::PivotalTracker::Project.new
    project.account = name
    project
  end
  
  describe "account names" do
    it "returns a unique list of the active projects' account names" do
      account_names = ["Secret Sauce Partners", "Pet Projects", "Secret Sauce Partners"]
      ::PivotalTracker::Project.should_receive(:all).and_return(account_names.map { |name| new_project(name) } )
      GitPit::PivotalTracker.account_names.should == ["Pet Projects", "Secret Sauce Partners"]
    end
  end
end