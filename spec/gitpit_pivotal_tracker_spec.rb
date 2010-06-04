require "spec_helper"

describe GitPit::PivotalTracker do
  before :all do
    GitPit::PivotalTracker.mode = :production
  end
  
  def new_project(hash)
    project = ::PivotalTracker::Project.new
    hash.each do |attribute, value|
      project.send("#{attribute}=", value)
    end
    project
  end
  
  it "returns a unique list of the active projects' account names" do
    account_names = ["Secret Sauce Partners", "Pet Projects", "Secret Sauce Partners"]
    ::PivotalTracker::Project.should_receive(:all).and_return(account_names.map { |name| new_project(:account => name) } )
    GitPit::PivotalTracker.account_names.should == ["Pet Projects", "Secret Sauce Partners"]
  end
  
  it "returns the overall velocity for an account" do
    projects = [
      { :account => "Secret Sauce Partners", :current_velocity => 2 },
      { :account => "Secret Sauce Partners", :current_velocity => 1 },
      { :account => "Pet Projects", :current_velocity  => 2 }
      ]
      
    ::PivotalTracker::Project.should_receive(:all).and_return(projects.map { |p| new_project(p) } )
    GitPit::PivotalTracker.overall_velocity("Secret Sauce Partners").should == 3
  end
end