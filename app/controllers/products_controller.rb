require 'csv'

class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  # upload product csv file
  def upload
    @files = CsvFile.all
  end

  # uploading the file
  # TODO: should put it in lib
  def uploading
    rows = []
    CSV.parse(params[:file].read) do |row|
      rows << row
    end
    saved_file = Time.now.strftime("%Y%m%d_%H%M%S_#{rand(100)}")
    CSV.open(File.join(Rails.root, 'public', 'csv', "#{saved_file}.csv"), 'w') do |csv|
      rows.each do |array|
        csv << array
      end
    end
    file = CsvFile.create(file_name: saved_file)
    redirect_to results_products_path(fid: file.id)
  end

  # products data come form csv
  def results
    @file = CsvFile.find(params[:fid])
    @products = @file.dump_products||[]
  end

  def importing
    file = CsvFile.find(params[:fid])
    pids = params[:pid]

    n = 0
    products = []
    CSV.foreach(File.join(Rails.root, 'public', 'csv', "#{file.file_name}.csv")) do |row|
      if n == 0
        n += 1
        next
      else
        products << row if pids.include?(n.to_s)
        n += 1
      end
    end

    # TODO: should be beauti.
    products.each do |row|
      Product.create(
        sku: row[0],
        name: row[1],
        sale_price: row[2].to_f,
        commission_amount: row[3].to_f,
        retail_price: row[4].to_f,
        )
    end

    redirect_to products_path

  end

  def sample
    send_file File.join(Rails.root, 'public', 'sample.csv')
  end


end
