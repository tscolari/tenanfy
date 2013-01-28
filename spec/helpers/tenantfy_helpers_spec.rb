require 'spec_helper'

module Tenantfy
  describe Helpers do
    let(:tenant) { FactoryGirl.create(:tenant) }

    before(:each) do
      helper.stub(:current_tenant).and_return(tenant)
    end

    context "Tenantfy Helpers" do
      describe "#tenant_stylesheet_link_tag" do
        it "should update the sources with the tenant theme and forward do ss_link_tag" do
          helper.should_receive(:append_tenant_theme_to_assets)
          helper.should_receive(:stylesheet_link_tag)
          helper.tenant_stylesheet_link_tag('application.css')
        end
      end

      describe "#tenant_javascript_include_tag" do
        it "should update the sources with the tenant theme and forward do js_include_tag" do
          helper.should_receive(:append_tenant_theme_to_assets)
          helper.should_receive(:javascript_include_tag)
          helper.tenant_javascript_include_tag('application.js')
        end
      end

      describe "#append_tenant_theme_to_assets" do
        context "single asset" do
          it "should append tenant theme only when not a full-path" do
            helper.send(:append_tenant_theme_to_assets, 'application.css').should eq ["#{tenant.theme}/application.css"]
            helper.send(:append_tenant_theme_to_assets, '/application.css').should eq ["/application.css"]
            helper.send(:append_tenant_theme_to_assets, 'http://b.com/application.css').should eq ["http://b.com/application.css"]
          end
        end

        context "multiple assets" do
          it "should append tenant theme only when not a full-path" do
            helper.send(:append_tenant_theme_to_assets, 
                        'application.css', '/application.css', 'http://b.com/application.css').should eq [
                          "#{tenant.theme}/application.css",
                          "/application.css",
                          "http://b.com/application.css"]
          end
        end
      end
    end
  end
end
