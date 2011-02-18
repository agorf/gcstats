require 'spec_helper'

include Helpers

describe Helpers do
  before do
    @caches = caches
  end

  it 'should return total finds' do
    total_finds.should == 40
  end

  it 'should return total finds with archived caches' do
    total_archived.should == 1
  end

  it 'should return number of days cached' do
    days_cached.should == 267
  end

  it 'should return finds per day' do
    finds_per_day.should == 0.15
  end

  it 'should return most finds in a day' do
    most_finds_in_a_day.should == 6
  end

  it 'should return dates with most finds in a day' do
    most_finds_in_a_day_dates.should == [Date.parse('2009-09-26')]
  end

  it 'should return finds by date' do
    finds_by_date.should == Hash[
      *[
        '2010-05-17', 1,
        '2009-10-18', 2,
        '2009-09-26', 6,
        '2009-11-01', 3,
        '2009-10-24', 1,
        '2010-03-18', 5,
        '2009-09-01', 3,
        '2009-10-29', 1,
        '2010-01-12', 2,
        '2009-09-02', 1,
        '2009-08-25', 1,
        '2009-11-26', 3,
        '2009-12-27', 1,
        '2009-08-23', 1,
        '2009-09-27', 3,
        '2010-03-14', 1,
        '2009-10-11', 5
      ].map {|e|
        e.is_a?(String) ? Date.parse(e) : e
      }.flatten
    ]
  end

  it 'should return finds by day of week' do
    finds_by_day_of_week.should == [1, 6, 1, 9, 0, 7, 16]
  end

  it 'should return finds by year' do
    finds_by_year.should == {2009 => 31, 2010 => 9}
  end

  it 'should return finds by size' do
    finds_by_size.should == [
      ['Small', 13],
      ['Regular', 13],
      ['Micro', 12],
      ['Other', 1],
      ['Not chosen', 1]
    ]
  end

  it 'should return finds by type' do
    finds_by_type.should == [
      ['Traditional Cache', 33],
      ['Unknown Cache', 3],
      ['Multi-cache', 3],
      ['Event Cache', 1]
    ]
  end

  it 'should return number of finds in difficulty/terrain combinations' do
    difficulty_terrain_combinations.should == [
      [7, 1, 1, 0, 1, 0, 0, 0, 0],
      [5, 3, 0, 0, 0, 0, 0, 0, 0],
      [1, 1, 8, 3, 2, 1, 0, 0, 0],
      [0, 1, 1, 0, 1, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
  end

  it 'should return number of finds in month/day combinations' do
    month_day_combinations.should == [
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, -1],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, -1],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,  0,  0],
      [3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 3, 0, 0,  0, -1],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1,  0,  0],
      [3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0,  0, -1],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0,  0,  0]
    ]
  end

  it 'should return finds by country' do
    finds_by_country.should == {'Greece' => 40}
  end

  it 'should return finds by state' do
    finds_by_state.should be_empty
  end

  it 'should return finds by cache owner' do
    finds_by_owner.should == [
      ['yiannisp', 9],
      ['teokar', 8],
      ['tetras61', 7],
      ['George & Christina', 4],
      ['YanniG', 3],
      ['GregoryGR', 2],
      ['Mark-X', 1],
      ['Hannera', 1],
      ['MaximillianGraves', 1],
      ['Pick', 1]
    ]
  end

  it 'should return geocacher name' do
    geocacher_name.should == 'agorf'
  end

  it 'should return dates of finds in descending order' do
    finds_dates.should == [
      '2010-05-17',
      '2010-03-18',
      '2010-03-14',
      '2010-01-12',
      '2009-12-27',
      '2009-11-26',
      '2009-11-01',
      '2009-10-29',
      '2009-10-24',
      '2009-10-18',
      '2009-10-11',
      '2009-09-27',
      '2009-09-26',
      '2009-09-02',
      '2009-09-01',
      '2009-08-25',
      '2009-08-23'
    ].map {|e| Date.parse(e) }
  end

  it 'should return render time' do
    @start_ts = Time.now
    Time.should_receive(:now).and_return(@start_ts + 10)
    render_time.should == 10.0
  end

  it 'should format percent with default precision 1' do
    format_percent(3, 9).should == '33.3%'
  end

  it 'should format percent with precision 0' do
    format_percent(3, 9, 0).should == '33%'
  end

  it 'should format percent with precision 2 (>1)' do
    format_percent(3, 9, 2).should == '33.33%'
  end
end
