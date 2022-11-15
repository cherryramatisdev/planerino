class DebitsController < ApplicationController
  before_action :set_debit, only: %i[ show edit update destroy ]

  # GET /debits or /debits.json
  def index
    @debits = Debit.all
  end

  # GET /debits/1 or /debits/1.json
  def show
  end

  # GET /debits/new
  def new
    @debit = Debit.new
  end

  # GET /debits/1/edit
  def edit
  end

  # GET /update_paid
  def update_paid
    @updated = Debit.toggle_paid(params[:id])
    respond_to do |format|
      if @updated
        format.html { redirect_to month_path(params[:month_id]) }
      else
        format.json { render json: @updated.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /debits or /debits.json
  def create
    if numeric?(debit_params[:owner_id])
      @debit = Debit.new({
        title: debit_params[:title],
        price: debit_params[:price],
        paid: debit_params[:paid],
        owner_id: debit_params[:owner_id],
        month_id: debit_params[:month_id]
      })
    else
      owner = Owner.find_or_create_by(name: debit_params[:owner_id])
      @debit = Debit.new({
        title: debit_params[:title],
        price: debit_params[:price],
        paid: debit_params[:paid],
        owner_id: owner.id,
        month_id: debit_params[:month_id]
      })
    end

    respond_to do |format|
      if @debit.save
        format.html { redirect_to debit_url(@debit), notice: "Debit was successfully created." }
        format.json { render :show, status: :created, location: @debit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debits/1 or /debits/1.json
  def update
    respond_to do |format|
      if @debit.update(debit_params)
        format.html { redirect_to debit_url(@debit), notice: "Debit was successfully updated." }
        format.json { render :show, status: :ok, location: @debit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debits/1 or /debits/1.json
  def destroy
    @debit.destroy

    respond_to do |format|
      format.html { redirect_to debits_url, notice: "Debit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_debit
    @debit = Debit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def debit_params
    params.require(:debit).permit(:id, :title, :price, :paid, :owner_id, :month_id)
  end

  def numeric?(target)
    Float(target) != nil rescue false
  end
end
