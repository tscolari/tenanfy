module Tenanfy
  module Apartment
    class Elevator 
      def call(request)
        tenant = Tenant.find_by_domain(request.host)
        if tenant
          tenant.schema_name
        else
          "public"
        end
      end
    end
  end
end
