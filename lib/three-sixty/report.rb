require_relative 'core/report'

module ThreeSixty
  class Report < ThreeSixty::Core::Report

    def all_keywords(start_date, level)
      keyword_data = []
      page = 1
      begin
        keywords = keyword(start_date, level, page: page)['keywordList']
        break if keywords.nil?
        keyword_data += keywords unless 
        page += 1
      end while keywords.count >= 1000
      keyword_data
    end

    def all_creatives(start_date, level)
      creative_data = []
      page = 1
      begin
        creatives = creative(start_date, level, page: page)['creativeList']
        break if creatives.nil?
        creative_data += creatives
        page += 1
      end while creatives.count >= 1000
      creative_data
    end

    def all_regions(start_date, level)
      region_data = []
      page = 1
      begin
        regions = region(start_date, level, page: page)['regionList']
        break if regions.nil?
        region_data += regions
        page += 1
      end while regions.count >= 1000
      region_data
    end

  end
end