require 'spec_helper'

module Tenanfy
  describe Tenant do
    let(:tenant) { FactoryGirl.create(:tenant, :with_url) }

    describe "#find_by_domain" do
      it "should return the correct tenant" do
        Tenant.find_by_domain(tenant.urls.first.url).should eq tenant
      end
    end

    describe "#switch_to_tenant" do
      it "should call Apartment switch with tenant's schema name" do
        ::Apartment::Database.stub(:switch).and_return(nil)
        ::Apartment::Database.should_receive(:switch).with(tenant.schema_name)
        tenant.switch_to_tenant
      end
    end

    describe "#schema_name" do
      it "should return schema in tenant_ID format" do
        tenant.schema_name.should eq "tenant_#{tenant.id}"
      end
    end

    describe "#build_schema" do
      it "should call Apartment create with schema_name" do
        ::Apartment::Database.stub(:create).and_return(nil)
        ::Apartment::Database.should_receive(:create).with(tenant.schema_name)
        tenant.send :build_schema
      end
    end

    describe "#drop_schema" do
      it "should call Apartment drop with schema_name" do
        ::Apartment::Database.stub(:drop).and_return(nil)
        ::Apartment::Database.should_receive(:drop).with(tenant.schema_name)
        tenant.send :drop_schema
      end
    end

  end
end

