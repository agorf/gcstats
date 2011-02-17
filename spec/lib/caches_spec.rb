require 'spec_helper'

describe Caches do
  let(:xml_data) {
    open(File.join(*%w{spec fixtures 3627915.gpx})).read
  }

  let(:caches) { Caches.from_xml(xml_data) }

  describe 'caches' do
    subject { caches }

    it { should have(40).items }

    describe 'first cache' do
      subject { caches.first }

      it { should be_an_instance_of(Caches::Cache) }

      its(:lat) { should == 39.712683 }
      it { should respond_to(:latitude) }

      its(:lon) { should == 21.637133 }
      it { should respond_to(:longitude) }

      its(:published) { should == Time.parse('Fri Jul 18 07:00:00 UTC 2003') }
      it { should respond_to(:time) }

      its(:code) { should == 'GCGJ59' }

      its(:url) { should == 'http://www.geocaching.com/seek/cache_details.aspx?guid=da011f9e-40fc-4b67-9de4-b56e1836ddbf' }

      its(:available?) { should be_true }

      its(:archived?) { should be_false }

      its(:name) { should == 'Meteora' }

      its(:owner) { should == 'Pick' }

      its(:placed_by) { should == 'Pick' }

      its(:type) { should == 'Traditional Cache' }

      its(:container) { should == 'Small' }
      it { should respond_to(:size) }

      its(:difficulty) { should == 1.0 }

      its(:terrain) { should == 2.0 }

      its(:country) { should == 'Greece' }

      its(:state) { should be_empty }

      its(:logs) { should have(1).item }

      its(:find_dates) { should == [Date.parse('2009-09-01T19:00:00Z')] }

      describe 'first log' do
        subject { caches.first.logs.first }

        it { should be_an_instance_of(Caches::Log) }

        its(:date) { should == Date.parse('2009-09-01T19:00:00Z') }

        its(:type) { should == 'Found it' }

        its(:finder) { should == 'agorf' }
      end
    end
  end
end
