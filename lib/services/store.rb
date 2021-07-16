require "json"

module Services
  class Store
    def initialize(filename)
      @filename = filename
      @scores_table = load_scores
    end

    def load_scores
      file_content = File.read(@filename)
      return [] if file_content.empty?

      JSON.parse(file_content, { symbolize_names: true })
    rescue Errno::ENOENT
      File.write(@filename, "")
      []
    end

    def update_scores_table(data)
      @scores_table << data
      persist_json
    end

    def sort_scores
      return [] if @scores_table.empty?

      @scores_table = load_scores
      @scores_table.sort { |player_one, player_two| player_two[:score] <=> player_one[:score] }
    end

    def persist_json
      File.write(@filename, @scores_table.to_json)
    end
  end
end
