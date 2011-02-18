require 'spec_helper'

module Helpers
  extend self
  @caches = caches
  @start_ts = Time.now
end

describe Helpers do
  its(:total_finds) { should == 40 }

  its(:total_archived) { should == 1 }

  its(:days_cached) { should == 267 }

  its(:finds_per_day) { should == 0.15 }

  its(:most_finds_in_a_day) { should == 6 }

  its(:most_finds_in_a_day_dates) { should == [Date.parse('2009-09-26')] }

  its(:finds_by_date) do
    should == Hash[
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

  its(:finds_by_day_of_week) { should == [1, 6, 1, 9, 0, 7, 16] }

  its(:finds_by_year) { should == {2009 => 31, 2010 => 9} }

  its(:finds_by_size) do
    should == [
      ['Small', 13],
      ['Regular', 13],
      ['Micro', 12],
      ['Other', 1],
      ['Not chosen', 1]
    ]
  end

  its(:finds_by_type) do
    should == [
      ['Traditional Cache', 33],
      ['Unknown Cache', 3],
      ['Multi-cache', 3],
      ['Event Cache', 1]
    ]
  end

  its(:difficulty_terrain_combinations) do
    should == [
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

  its(:month_day_combinations) do
    should == [
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

  its(:finds_by_country) { should == {'Greece' => 40} }

  its(:finds_by_state) { should be_empty }

  its(:finds_by_owner) do
    should == [
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

  its(:geocacher_name) { should == 'agorf' }

  its(:finds_dates) do
    should == [
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
    start_ts = Helpers.instance_variable_get('@start_ts')
    Time.should_receive(:now).and_return(start_ts + 10)
    subject.render_time.should == 10.0
  end

  it 'should format percent with default precision 1' do
    subject.format_percent(3, 9).should == '33.3%'
  end

  it 'should format percent with precision 0' do
    subject.format_percent(3, 9, 0).should == '33%'
  end

  it 'should format percent with precision 2 (>1)' do
    subject.format_percent(3, 9, 2).should == '33.33%'
  end
end
