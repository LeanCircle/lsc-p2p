require 'spec_helper'

describe Group do
  before do
    allow_any_instance_of(Group).to receive(:fetch_events_from_meetup)
  end
  it { should belong_to :user }
  it { should have_many :events }

  describe "#remove_inactive" do
    context 'it has NO events' do
      it 'return true' do
        group = FactoryGirl.create(:group)

        expect(group.remove_inactive).to be true
      end
    end

    context 'all events are more than 6 months ago' do
      it 'return true' do
        group = FactoryGirl.create(:group)
        group.events = [FactoryGirl.create(:event, group: group, start_datetime: 7.months.ago)]

        expect(group.remove_inactive).to be true
      end
    end

    context 'at least one event is less than 6 months ago' do
      it 'return false' do
        group = FactoryGirl.create(:group)
        group.events = [FactoryGirl.create(:event, group: group, start_datetime: 5.months.ago)]

        expect(group.remove_inactive).to be false
      end
    end
  end

  describe ".nearest" do
    it 'calls Group.near with 50 (miles)' do
      FactoryGirl.create(:group) #factory returns a group in SF
      loc = Geocoder.search("San Francisco").first

      expect(Group).to receive(:near).with(loc.coordinates, 50).and_call_original

      Group.nearest(loc)
    end

    it 'includes approved groups' do
      g1 = FactoryGirl.create(:group, approval: true)
      g1.events = [FactoryGirl.create(:event, group: g1, start_datetime: 5.months.ago)]
      g2 = FactoryGirl.create(:group, approval: false)
      g2.events = [FactoryGirl.create(:event, group: g1, start_datetime: 5.months.ago)]
      loc = Geocoder.search("San Francisco").first

      g = Group.nearest(loc)

      expect(g).to include(g1)
      expect(g).to_not include(g2)
    end

  end
end

