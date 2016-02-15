module PixelproSdk
  class PhantomOauth
    class AccessToken
      def initialize(access_token, update_token)
        @access_token = access_token
        @update_token = update_token
      end

      def method_missing(name, *args, &block)
        is_param = true
        m=/\A[a-z]+(_([a-z]+?))+?_by\z/.match(name.to_s)
        if m.nil?
          m=/\A[a-z]+(_([a-z]+?))+?\z/.match(name.to_s)
          is_param = false
          super(method, *args, &block) if m.nil?
        end

        method_arr = name.to_s.split '_'

        method_name = method_arr[0]
        method_param = name.to_s.sub(/[a-z]+_/,"").sub(/_by/,"")


        super(name, *args, &block) unless (["put","get","post","delete"].include? method_name)

        if is_param
          throw "parameters without id error" unless (args && args[0].has_key?(:id))
          if args[0].has_key?(:action)

          else
            url = "/api/#{method_param}/#{args[0][:id]}"
          end
        else
          url = "/api/#{method_param}"
        end

        res = self.conn_send method_name,url

        if (res.status == 200)
          return {:success => (res.status == 200),:body => JSON.parse(res.body),:status => res.status}
        else
          return {:success => (res.status == 200),:status => res.status}
        end
      end

      def conn_send method_name, url
        req_conn = Faraday.new(:url => PHANTOM_API_URL, :ssl => {:verify => false}) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        if (method_name == "get" || method_name == "delete")
          res= req_conn.send(method_name.to_sym){
              |req|
              req.url url
              req.headers['Authorization'] = "bearer #{@access_token}"
              req.headers['Accept'] = "application/vnd.huantengsmart-v1+json"
          }
        else
          
        end
      end

    end
  end
end
