class Warehouses < Application
  # provides :xml, :yaml, :js

  def index
    @warehouses = Warehouse.all
    display @warehouses
  end

  def show(id)
    @warehouse = Warehouse.get(id)
    raise NotFound unless @warehouse
    display @warehouse
  end

  def new
    only_provides :html
    @warehouse = Warehouse.new
    display @warehouse
  end

  def edit(id)
    only_provides :html
    @warehouse = Warehouse.get(id)
    raise NotFound unless @warehouse
    display @warehouse
  end

  def create(warehouse)
    @warehouse = Warehouse.new(warehouse)
    if @warehouse.save
      redirect resource(@warehouse), :message => {:notice => "Warehouse was successfully created"}
    else
      message[:error] = "Warehouse failed to be created"
      render :new
    end
  end

  def update(id, warehouse)
    @warehouse = Warehouse.get(id)
    raise NotFound unless @warehouse
    if @warehouse.update_attributes(warehouse)
       redirect resource(@warehouse)
    else
      display @warehouse, :edit
    end
  end

  def destroy(id)
    @warehouse = Warehouse.get(id)
    raise NotFound unless @warehouse
    if @warehouse.destroy
      redirect resource(:warehouses)
    else
      raise InternalServerError
    end
  end

end # Warehouses
