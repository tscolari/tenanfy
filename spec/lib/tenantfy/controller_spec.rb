require 'spec_helper'

module Tenanfy
  class TestController < ActionController::Base
    include Tenanfy::Controller
  end

  describe Controller do
    let(:tenant) { FactoryGirl.create(:tenant) }
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

    describe "#current_tenant_theme" do
      context "there is a tenant" do
        before(:each) do
          url = FactoryGirl.create(:url, tenant: tenant)
          subject.stub_chain(:request, :host).and_return(url.url)
        end

        it "should return the current tenant theme" do
          subject.send(:current_tenant_theme).should eq tenant.theme
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

    describe "#prepend_tenant_theme" do
      context "there is a tenant" do
        before(:each) do
          url = FactoryGirl.create(:url, tenant: tenant)
          subject.stub_chain(:request, :host).and_return(url.url)
        end

        it "should prepend the tenant view theme" do
          subject.should_receive(:prepend_view_path).with(tenant.theme_path)
          subject.send(:prepend_tenant_theme)
        end
      end

      context "no tenant found" do
        it "should prepend the tenant view theme" do
          subject.should_receive(:prepend_view_path).never
          subject.send(:prepend_tenant_theme)
        end
      end
    end
  end
end
