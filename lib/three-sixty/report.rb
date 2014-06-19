require_relative 'core/report'

module ThreeSixty
  class Report < ThreeSixty::Core::Report

    def all_keywords(start_date, level)
      keyword_data = []
      page = 0
      begin
        keywords = keyword(start_date, level, page: page)['keywordList']
        keyword_data += keywords unless keywords.nil?
        page += 1
      end while keywords.count >= 1000
      keyword_data
    end

    def all_creatives(start_date, level)
      creative_data = []
      page = 0
      begin
        creatives = creative(start_date, level, page: page)['creativeList']
        creative_data += creatives unless creatives.nil?
        page += 1
      end while creatives.count >= 1000
      creative_data
    end

    def all_regions(start_date, level)
      region_data = []
      page = 0
      begin
        regions = region(start_date, level, page: page)['regionList']
        region_data += regions unless regions.nil?
        page += 1
      end while regions.count >= 1000
      region_data
    end

  end
end