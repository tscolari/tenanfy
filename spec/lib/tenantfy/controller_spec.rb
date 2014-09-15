require 'spec_helper'

module Tenanfy
  class TestController < ActionController::Base
    include Tenanfy::Controller
  end

  describe Controller do
    let(:tenant) { FactoryGirl.create(:tenant, themes: ["theme1", "theme2"]) }
    subject { TestController.new }

    before(:each) { subject.stub_chain(:request, :host).and_return(nil) }

    describe "#current_tenant" do
      context "there is a tenant" do
        before(:each) do
          url = FactoryGirl.create(:url, tenant: tenant)
          subject.stub_chain(:request, :host).and_return(url.url)
        end

        it "should return the current tenant" do
          subject.send(:current_tenant).should eq tenant
        end
      end

      context "no tenant found" do
        it "should return nil" do
          subject.send(:current_tenant).should eq nil
        end
      end
    end

    describe "#current_tenant_themes" do
      context "there is a tenant" do
        before(:each) do
          url = FactoryGirl.create(:url, tenant: tenant)
          subject.stub_chain(:request, :host).and_return(url.url)
        end

        it "should return the current tenant themes" do
          subject.send(:current_tenant_themes).should eq tenant.themes
        end
      end

      context "no tenant found" do
        it "should return a blank string" do
          subject.send(:current_tenant_themes).should eq []
        end
      end
    end

    describe "#current_tenant_theme" do
      context "there is a tenant" do
        before(:each) do
          url = FactoryGirl.create(:url, tenant: tenant)
          subject.stub_chain(:request, :host).and_return(url.url)
        end

        it "should return the current tenant themes" do
          subject.send(:current_tenant_theme).should eq tenant.themes.first
        end
      end

      context "no tenant found" do
        it "should return a blank string" do
          subject.send(:current_tenant_theme).should eq ""
        end
      end
    end

    describe "#current_tenant_name" do
      context "there is a tenant" do
        before(:each) do
          url = FactoryGirl.create(:url, tenant: tenant)
          subject.stub_chain(:request, :host).and_return(url.url)
        end

        it "should return the current tenant name" do
          subject.send(:current_tenant_name).should eq tenant.name
        end

      end

      context "no tenant found" do
        it "should return Global" do
          subject.send(:current_tenant_name).should eq "Global"
        end
      end
    end

    describe "#prepend_tenant_themes" do
      context "there is a tenant" do
        before(:each) do
          url = FactoryGirl.create(:url, tenant: tenant)
          subject.stub_chain(:request, :host).and_return(url.url)
        end

        it "should prepend the tenant view theme" do
          subject.should_receive(:prepend_view_path).with(tenant.theme_paths)
          subject.send(:prepend_tenant_themes)
        end
      end

      context "no tenant found" do
        it "should prepend the tenant view theme" do
          subject.should_receive(:prepend_view_path).never
          subject.send(:prepend_tenant_themes)
        end
      end
    end
  end
end
