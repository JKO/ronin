require 'spec_helper'
require 'model/models/described_model'

require 'ronin/model/has_description'

describe Model::HasDescription do
  subject { DescribedModel }

  before(:all) { subject.auto_migrate! }

  it "should include Ronin::Model" do
    subject.ancestors.should include(Model)
  end

  it "should define a description property" do
    subject.properties.should be_named(:description)
  end

  it "should be able to find resources with similar descriptions" do
    subject.create!(:description => 'foo one')
    subject.create!(:description => 'foo bar two')

    resources = subject.describing('foo')

    resources.length.should == 2
    resources[0].description.should == 'foo one'
    resources[1].description.should == 'foo bar two'
  end
end
