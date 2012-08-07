ActiveAdmin.register Deal do
  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :camp_id
    end
    f.inputs "Content" do
      f.input :description
    end
    f.buttons
  end
end
