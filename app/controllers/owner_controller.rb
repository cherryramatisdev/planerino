# typed: true

class OwnerController < ApplicationController
  # GET /get_debit_total/1?month_id=1
  def get_total
    @total = Owner.find(params[:id]).debit.where(month_id: params[:month_id], paid: false).sum { |e| e.price }
    respond_to do |format|
      if @total
        format.json { render json: { total: @total }, status: :ok }
      else
        format.json { render json: { message: 'Could not process total per owner' }, status: :unprocessable_entity }
      end
    end
  end
end
