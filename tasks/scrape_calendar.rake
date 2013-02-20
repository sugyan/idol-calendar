require 'google/api_client'

task :scraping do
  client = Google::APIClient.new(:application_name => 'idol-calendar', :version => '0.0.1')
  client.authorization = Signet::OAuth2::Client.new(
    :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
    :audience             => 'https://accounts.google.com/o/oauth2/token',
    :scope                => 'https://www.googleapis.com/auth/calendar.readonly',
    :issuer               => ENV['GOOGLE_API_EMAILADDRESS'],
    :signing_key          => OpenSSL::PKey::RSA.new(ENV['GOOGLE_API_KEY']),
  )
  client.authorization.fetch_access_token!

  result = client.execute(
    :api_method => client.discovered_api('calendar', 'v3').events.list,
    :parameters => {
      'calendarId'   => 'momocloch@gmail.com',
      'singleEvents' => 'true',
      'orderBy'      => 'startTime',
      'timeMin'      => DateTime.now,
      'timeMax'      => DateTime.now + 7,
    },
  )
  result.data.items.each do |item|
    p "#{ item.start['dateTime'] || item.start['date'] } - #{ item.end['dateTime']   || item.end['date'] }: #{ item.summary }"
  end
end
