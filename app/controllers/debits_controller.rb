# typed: true
# frozen_string_literal: true

class DebitsController < ApplicationController
  before_action :set_debit, only: %i[show edit update destroy]

  # GET /debits or /debits.json
  def index
    @debits = Debit.all
  end

  # GET /debits/new
  def new
    @debit = Debit.new
    @month_id = params[:month_id]
  end

  # GET /debits/1/edit
  def edit
    @month_id = params[:month_id]
  end

  # GET /get_debit_total?title=NUBANK?month_id=1
  def total
    @total = Debit.all.where(title: params[:title]).where(month_id: params[:month_id], paid: false).sum(&:price)
    respond_to do |format|
      if @total
        format.json { render json: { total: @total }, status: :ok }
      else
        format.json { render json: { message: 'Could not process total per owner' }, status: :unprocessable_entity }
      end
    end
  end

  # GET /update_paid/1
  def update_paid
    @updated = Debit.toggle_paid(params[:id].to_s.to_i)
    respond_to do |format|
      if @updated.errors
        format.json { render json: @updated.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to month_path(params[:month_id]) }
        format.json { render json: { debit_paid: Debit.find(params[:id]).paid }, status: :ok }
      end
    end
  end

  # POST /debits or /debits.json
  def create
    price = sanitize_price(debit_params[:price])

    unless numeric?(price)
      return redirect_to new_debit_path(month_id: debit_params[:month_id]),
                         notice: 'Preço deve conter apenas números e ponto ou virgula como separação'
    end

    @debit = create_new_debit_with_owner({
                                           title: debit_params[:title],
                                           price:,
                                           paid: debit_params[:paid],
                                           owner_id: debit_params[:owner_id],
                                           month_id: debit_params[:month_id]
                                         })

    respond_to do |format|
      if @debit.save
        format.html { redirect_to month_url(debit_params[:month_id]), notice: 'Debito foi adicionado com sucesso.' }
        format.json { render :show, status: :created, location: @debit }
      else
        format.html do
          redirect_to new_debit_path(month_id: debit_params[:month_id]), notice: @debit.errors.full_messages.join(',')
        end
        format.json { render json: @debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debits/1 or /debits/1.json
  def update
    price = sanitize_price(debit_params[:price])

    unless numeric?(price)
      return redirect_to debit_path(@debit, month_id: debit_params[:month_id]),
                         notice: 'Preço deve conter apenas números e ponto ou virgula como separação'
    end

    respond_to do |format|
      if @debit.update({
                         title: debit_params[:title],
                         price:,
                         paid: debit_params[:paid],
                         owner_id: debit_params[:owner_id],
                         month_id: debit_params[:month_id]
                       })
        format.html { redirect_to month_url(debit_params[:month_id]), notice: 'Debito foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @debit }
      else
        format.html do
          redirect_to debit_path(@debit, month_id: debit_params[:month_id]),
                      notice: @debit.errors.full_messages.join(',')
        end
        format.json { render json: @debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debits/1?month_id=1 or /debits/1.json?month_id=1
  def destroy
    @debit.destroy

    respond_to do |format|
      format.html { redirect_to month_url(params[:month_id]), notice: 'Debito foi excluido com sucesso.' }
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
    T.cast(params.require(:debit), ActionController::Parameters).permit(:id, :title, :price, :paid, :owner_id,
                                                                        :month_id)
  end

  def numeric?(target)
    return true if Float(target)
  rescue StandardError
    false
  end

  def create_new_debit_with_owner(obj_params)
    created_owner = Owner.find_or_create_by(name: obj_params[:owner_id].upcase)
    @debit = Debit.new({
                         title: obj_params[:title],
                         price: obj_params[:price],
                         paid: obj_params[:paid],
                         owner_id: created_owner.id,
                         month_id: obj_params[:month_id]
                       })
  end

  def sanitize_price(price)
    if price.empty?
      '0'
    else
      price.gsub('.', '').gsub(',', '.')
    end
  end
end
