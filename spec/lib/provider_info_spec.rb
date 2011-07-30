require 'spec_helper'

describe ProviderInfo do
  describe '#settings' do
    context "providers.yml is present" do
      it "should return a hash of provider data" do
        info = ProviderInfo.new.settings
        info.should be_a(Hash)
      end
    end

    context 'providers.yml is missing' do
      before do
        @provider_info = ProviderInfo.new
        @provider_info.stub!(:config_file).and_return('')
      end

      it "should raise an error" do
        lambda { @provider_info.settings }.should raise_error
      end
    end
  end

  context '#config_file' do
    it "should return the path to provider.yml" do
      p = ProviderInfo.new
      p.config_file.should == File.join(Rails.root, 'config', 'providers.yml')
    end
  end
end