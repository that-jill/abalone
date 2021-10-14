class MeasurementsController < ApplicationController
  before_action :authorize_admin!, only: %i[edit]
  before_action :set_measurement, only: %i[show edit update]

  def index
    @measurements = Measurement.all
  end

  def show; end

  def edit; end

  def update
    if @measurement.update(measurement_params)
      redirect_to @measurement, notice: 'Measurement was successfully updated.'
    else
      render :edit
    end
  end

  def new; end

  helper_method def subject_name_label
    if @measurement.subject_type == "Animal"
      "Animal Tag"
    elsif @measurement.subject_type == "Cohort"
      "Cohort Name"
    else
      "Enclosure Name"
    end
  end

  helper_method def subject_name_value
    if @measurement.subject_type == "Animal"
      @measurement.animal_tag
    elsif @measurement.subject_type == "Cohort"
      @measurement.cohort_name
    else
      @measurement.enclosure_name
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_measurement
    @measurement = Measurement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def measurement_params
    params.require(:measurement).permit(
      :value,
      :subject_type,
      :measurement_type_id
    ).merge(organization_id: current_organization.id)
  end
end
