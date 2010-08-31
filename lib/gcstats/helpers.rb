class Array
  def sum
    inject {|a, e| a + e }
  end
end

module GCStats
  module Helpers
    LEAP_YEAR_MONTH_DAYS = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    RFC2822_DAY_NAME = %w{Sun Mon Tue Wed Thu Fri Sat} # US, Canada, Japan
    ISO8601_DAY_NAME = %w{Mon Tue Wed Thu Fri Sat Sun} # everywhere else
    DAY_NAME = ISO8601_DAY_NAME

    def total_finds
      @total_finds ||= @caches.map {|c| c.find_dates.size }.sum
    end

    def total_archived
      @caches.select {|c| c.archived? }.map {|c| c.find_dates.size }.sum
    end

    def days_cached
      @days_cached ||= begin
        dates = finds_by_date.keys.sort
        (dates[-1] - dates[0]).to_i
      end
    end

    def finds_per_day
      sprintf('%.2f', total_finds / days_cached.to_f).to_f
    end

    def most_finds_in_a_day
      @most_finds_in_a_day ||= finds_by_date.values.max
    end

    def most_finds_in_a_day_dates
      finds_by_date.select {|d, f| f == most_finds_in_a_day }.map {|d, f| d }.sort
    end

    def finds_by_date
      @finds_by_date ||= begin
        finds = {}

        @caches.each {|cache|
          cache.find_dates.each {|find_date|
            begin
              finds[find_date] += 1
            rescue
              finds[find_date] = 1
            end
          }
        }

        finds
      end
    end

    def finds_by_day_of_week
      finds = Array.new(7, 0)

      finds_by_date.each {|date, finds_on_date|
        if DAY_NAME[0] == 'Mon'
          wday = date.cwday - 1
        else
          wday = date.wday
        end

        begin
          finds[wday] += finds_on_date
        rescue
          finds[wday] = finds_on_date
        end
      }

      finds
    end

    def finds_by_year
      @finds_by_year ||= begin
        finds = {}

        finds_by_date.each {|date, finds_on_date|
          begin
            finds[date.year] += finds_on_date
          rescue
            finds[date.year] = finds_on_date
          end
        }

        # fill empty years with 0
        (finds.keys.min + 1...finds.keys.max).each {|year|
          finds[year] ||= 0
        }

        finds
      end
    end

    def finds_by_size
      finds = {}

      @caches.each {|cache|
        begin
          finds[cache.container] += cache.find_dates.size
        rescue
          finds[cache.container] = cache.find_dates.size
        end
      }

      finds.to_a.sort {|x, y| y[1] <=> x[1] }
    end

    def finds_by_type
      finds = {}

      @caches.each {|cache|
        begin
          finds[cache.type] += cache.find_dates.size
        rescue
          finds[cache.type] = cache.find_dates.size
        end
      }

      finds.to_a.sort {|x, y| y[1] <=> x[1] }
    end

    def difficulty_terrain_combinations
      @difficulty_terrain_combinations ||= begin
        combinations = Array.new(9) { Array.new(9, 0) } # 9x9 array

        @caches.each {|cache|
          i = 2 * (cache.difficulty - 1)
          j = 2 * (cache.terrain - 1)
          combinations[i][j] += cache.find_dates.size
        }

        combinations
      end
    end

    def month_day_combinations
      @month_day_combinations ||= begin
        combinations = Array.new(12) { Array.new(31, 0) } # 12x31 array

        finds_by_date.each {|date, finds_on_date|
          i = date.month - 1
          j = date.day - 1
          combinations[i][j] += finds_on_date
        }

        # mark erroneous combinations (e.g. Feb 30-31)
        LEAP_YEAR_MONTH_DAYS.each_with_index {|days, i|
          (days..30).each {|j|
            combinations[i][j] = -1
          }
        }

        combinations
      end
    end

    def finds_by_country
      @finds_by_country ||= begin
        finds = {}

        @caches.each {|cache|
          begin
            finds[cache.country] += cache.find_dates.size
          rescue
            finds[cache.country] = cache.find_dates.size
          end
        }

        finds
      end
    end

    def finds_by_state
      @finds_by_state ||= begin
        finds = {}

        @caches.each {|cache|
          begin
            finds[cache.state] += cache.find_dates.size
          rescue
            finds[cache.state] = cache.find_dates.size
          end
        }

        finds
      end
    end

    def geocacher_name
      @caches[0].logs[0].finder
    end

    def finds_dates
      @finds_dates ||= finds_by_date.keys.sort.reverse
    end
  end
end
