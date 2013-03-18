class GithubJobs

  BASE_URL = 'https://jobs.github.com/positions.json'

  def self.search(options = {}, &block)
    BW::HTTP.get(BASE_URL, {payload: options}) do |response|
      if response.status_code != 200
        block.call []
      else
        block.call BW::JSON.parse(response.body.to_str)
      end
    end
  end
end