class BaseItems < Application
  # provides :xml, :yaml, :js

  def index
    @base_items = BaseItem.all
    display @base_items
  end

  def show(id)
    @base_item = BaseItem.get(id)
    raise NotFound unless @base_item
    display @base_item
  end

  def new
    only_provides :html
    @base_item = BaseItem.new
    display @base_item
  end

  def edit(id)
    only_provides :html
    @base_item = BaseItem.get(id)
    raise NotFound unless @base_item
    display @base_item
  end

  def create(base_item)
    @base_item = BaseItem.new(base_item)
    if @base_item.save
      redirect resource(@base_item), :message => {:notice => "BaseItem was successfully created"}
    else
      message[:error] = "BaseItem failed to be created"
      render :new
    end
  end

  def update(id, base_item)
    @base_item = BaseItem.get(id)
    raise NotFound unless @base_item
    if @base_item.update_attributes(base_item)
       redirect resource(@base_item)
    else
      display @base_item, :edit
    end
  end

  def destroy(id)
    @base_item = BaseItem.get(id)
    raise NotFound unless @base_item
    if @base_item.destroy
      redirect resource(:base_items)
    else
      raise InternalServerError
    end
  end

end # BaseItems
