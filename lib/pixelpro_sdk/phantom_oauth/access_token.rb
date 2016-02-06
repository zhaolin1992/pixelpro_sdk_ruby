module PixelproSdk
  class PhantomOauth
    class AccessToken
      def initialize(access_token, update_token)
        @access_token = access_token
        @update_token = update_token
      end

      def method_missing(name, *args, &block)
        is_param = true
        m=/\A[a-z]+_(_([a-z]+?))+?_by\z/.match(name.to_s)
        if m.nil?
          m=/\A[a-z]+(_([a-z]+?))+?\z/.match(name.to_s)
          is_param = false
          super(method, *args, &block) if m.nil?
        end

        method_arr = name.to_s.split '_'

        method_name = method_arr[0]
        method_param = name.to_s.sub(/[a-z]+_/,"").sub(/_by/,"")


        super(method, *args, &block) unless (["put","get","post","delete"].include? method_name)

        req_conn = Faraday.new(:url => PHANTOM_API_URL, :ssl => {:verify => false}) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end

        res= req_conn.send(method_name.to_sym){
            |req|
            req.url "/api/#{method_param}"
            req.headers['Authorization'] = "bearer #{@access_token}"
            req.headers['Accept'] = "application/vnd.huantengsmart-v1+json"
        }

        return {:success => (res.status == 200),:body => JSON.parse(res.body),:status => res.status}

      end

    end
  end
end
