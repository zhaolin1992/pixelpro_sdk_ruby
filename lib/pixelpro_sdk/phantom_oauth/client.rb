module PixelproSdk
  class PhantomOauth
    class Client

      attr_reader :id, :secret, :site
      attr_accessor :options
      attr_writer :connection

      def initialize(client_id, client_secret, options = {}, &block)
        opts = options.dup
        @id = client_id
        @secret = client_secret
        @redirect_url = opts.delete(:redirect_url)
      end

      def callback_handler code
        param ={
          client_secret: @secret,
          client_id: @id,
          grant_type: 'authorization_code',
          redirect_uri: @redirect_url,
          code: code
        }

        auth_conn = Faraday.new(:url => PixelproSdk::PhantomOauth::PHANTOM_GET_TOKEN_URL, :ssl => {:verify => false}) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end

        res = auth_conn.post('/oauth2/token',param)

        if (res.status != 200)
          render json: {success: false, code: 1}
          return
        end

        jres = JSON.parse(res.body)
        access_token = jres["access_token"]
        refresh_token = jres["refresh_token"]

        token = PixelproSdk::PhantomOauth::AccessToken.new(access_token,refresh_token)

        token
      end




    end
  end
end
