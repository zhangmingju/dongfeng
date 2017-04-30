require 'rails_helper'

describe ArticlesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get('/articles')).to route_to('articles#index')
    end

    it 'routes to #show' do
      expect(get('/articles/1')).to route_to('articles#show', id: '1')
    end


    it 'routes to #preview' do
      expect(post('/admin/articles/preview')).to route_to('admin/articles#preview')
    end

    it 'routes to #publish' do
      expect(get('/admin/articles/1/publish')).to route_to('admin/articles#publish',id:'1')
    end

    it 'routes to admin#index' do
      expect(get('/admin/articles')).to route_to('admin/articles#index')
    end
    it 'routes to admin#create' do
      expect(post('/admin/articles')).to route_to('admin/articles#create')
    end


    it 'routes to admin#new' do
      expect(get('/admin/articles/new')).to route_to('admin/articles#new')
    end

    it 'routes to admin#edit' do
      expect(get('/admin/articles/1/edit')).to route_to('admin/articles#edit', id: '1')
    end

    it 'routes to admin#show' do
      expect(get('/admin/articles/1')).to route_to('admin/articles#show',id: '1')
    end

    it 'routes to admin#update' do
      expect(put('/admin/articles/1')).to route_to('admin/articles#update', id: '1')
    end

    it 'routes to admin#destroy' do
      expect(delete('/admin/articles/1')).to route_to('admin/articles#destroy', id: '1')
    end
  end
end
