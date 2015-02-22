require 'spec_helper'

describe GroupsController do

  describe "#setup_location" do
    context "@location is blank" do
      it '@location gets set to request.location' do
        controller.instance_variable_set('@location', nil)

        controller.send(:setup_location)

        expect(controller.instance_variable_get('@location')).to eq request.location
      end
    end
    context "@location is not blank" do
      it 'does nothing' do
        loc = Geocoder.search("Chicago").first
        controller.instance_variable_set('@location', loc)

        controller.send(:setup_location)

        expect(controller.instance_variable_get('@location')).to eq loc
      end
    end
  end

  describe "#location_setup" do
    it 'calls Group.nearest' do
      controller.send(:setup_location)
      loc = controller.instance_variable_get('@location')

      expect(Group).to receive(:nearest).with(loc)
      controller.send(:location_setup)
    end
  end
end


