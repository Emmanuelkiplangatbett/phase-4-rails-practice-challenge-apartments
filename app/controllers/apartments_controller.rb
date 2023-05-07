class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_no_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    def index
        render json: Apartment.all, status: :ok
    end

    def show 
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find_by(id: params[:id])
        apartment.update(apartment_params)
        render json: apartment, status: :accepted
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private
    def apartment_params
        params.permit(:number)
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end

end
