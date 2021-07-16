require "json"

module Services
  class Store
    def initialize(filename)
      @filename = filename
      @scores_table = load_scores
    end

    def load_scores
      JSON.parse(File.read(@filename), { symbolize_names: true })
    rescue Errno::ENOENT
      File.write(@filename, "")
      []
    end

    def update_scores_table(data)
      @scores_table << data
      persist_json
    end

    def persist_json
      File.write(@filename, @scores_table.to_json)
    end
  end
end
