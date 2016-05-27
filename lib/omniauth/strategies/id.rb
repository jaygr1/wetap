require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies

    class Id < OmniAuth::Strategies::OAuth2
      option :name, :id

      option :client_options, {
        site:           ENV["SITE"],
        authorize_path: "/oauth/authorize"
      }

      uid do
        raw_info['uuid']
      end

      name do
        raw_info['name']
      end

      info do
        {
          gender:     raw_info['gender'],
          kind:       raw_info['kind'],
          email:      raw_info['email'].downcase,
          dob:        raw_info['date_of_birth'],
          roles:      raw_info["role_strings"],
          status:     raw_info["status"],
          name:       raw_info['name'],
          seats:      raw_info['seats']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/users/1').parsed
      end
    end
  end
end
