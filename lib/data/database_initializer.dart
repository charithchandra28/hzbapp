import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseInitializer {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> initializeDatabase() async {
    final queries = [
      '''
      CREATE TABLE IF NOT EXISTS categories (
          id SERIAL PRIMARY KEY,
          name TEXT NOT NULL,
          icon_url TEXT NOT NULL
      );
      ''',
      '''
      CREATE TABLE IF NOT EXISTS products (
          id SERIAL PRIMARY KEY,
          name TEXT NOT NULL,
          price DECIMAL(10, 2) NOT NULL,
          image_url TEXT NOT NULL,
          category_id INT REFERENCES categories(id) ON DELETE CASCADE
      );
      ''',
      '''
      CREATE TABLE IF NOT EXISTS promotions (
          id SERIAL PRIMARY KEY,
          title TEXT NOT NULL,
          image_url TEXT NOT NULL,
          description TEXT DEFAULT NULL
      );
      ''',
      '''
      INSERT INTO categories (name, icon_url) 
      VALUES
      ('Groceries', 'https://images.unsplash.com/photo-1516594798947-e65505dbb29d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z3JvY2VyeXxlbnwwfHwwfHx8MA%3D%3D'),
      ('Electronics', 'https://plus.unsplash.com/premium_photo-1679079456083-9f288e224e96?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZWxlY3Ryb25pY3N8ZW58MHx8MHx8fDA%3D'),
      ('Pharmacy', 'https://plus.unsplash.com/premium_photo-1663047392930-7c1c31d7b785?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhhcm1hY3l8ZW58MHx8MHx8fDA%3D'),
      ('Clothing', 'https://plus.unsplash.com/premium_photo-1664202526475-8f43ee70166d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8Y2xvdGhpbmd8ZW58MHx8MHx8fDA%3D'),
       ('Clothing', 'https://plus.unsplash.com/premium_photo-1664202526475-8f43ee70166d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8Y2xvdGhpbmd8ZW58MHx8MHx8fDA%3D')

      ON CONFLICT DO NOTHING;
      ''',
      '''
      INSERT INTO products (name, price, image_url, category_id)
      VALUES
      ('Apple', 1.50, 'https://plus.unsplash.com/premium_photo-1724249989963-9286e126af81?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YXBwbGV8ZW58MHx8MHx8fDA%3D', 1),
      ('Laptop', 799.99, 'https://images.unsplash.com/photo-1484788984921-03950022c9ef?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGFwdG9wfGVufDB8fDB8fHww', 2),
      ('Headphones', 29.99, 'https://plus.unsplash.com/premium_photo-1679513691474-73102089c117?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8aGVhZHBob25lc3xlbnwwfHwwfHx8MA%3D%3D', 2),
      ('Vitamin C', 12.99, 'https://media.istockphoto.com/id/993119894/photo/food-containing-vitamin-c-healthy-eating.webp?a=1&b=1&s=612x612&w=0&k=20&c=p0U_dGc-hFXXcRW4QggD5ySyPkivUBxlkPlyCI0byM4=', 3),
      ('Shirt', 19.99, 'https://plus.unsplash.com/premium_photo-1678218594563-9fe0d16c6838?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2hpcnR8ZW58MHx8MHx8fDA%3D', 4),
      ('Jeans', 39.99, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8amVhbnN8ZW58MHx8MHx8fDA%3D', 4)
      ON CONFLICT DO NOTHING;
      ''',
      '''
      INSERT INTO promotions (title, image_url, description)
      VALUES
      ('10% Off on Groceries', 'https://plus.unsplash.com/premium_photo-1726869616627-60e146f01539?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8MTAlMjUlMjBPZmYlMjBvbiUyMEdyb2Nlcmllc3xlbnwwfHwwfHx8MA%3D%3D', 'Save 10% on all grocery items this week!'),
      ('Buy One Get One Free on Headphones', 'https://plus.unsplash.com/premium_photo-1682096475747-a744ab3f55ab?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8QnV5JTIwT25lJTIwR2V0JTIwT25lJTIwRnJlZSUyMG9uJTIwSGVhZHBob25lc3xlbnwwfHwwfHx8MA%3D%3D', 'Limited-time offer on electronics!'),
      ('Flat 5 Off on Vitamin C', 'https://plus.unsplash.com/premium_photo-1700028099941-3cbba01e9974?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8RmxhdCUyMDUlMjBPZmYlMjBvbiUyMFZpdGFtaW4lMjBDfGVufDB8fDB8fHww', 'Stay healthy and save money!')
      ON CONFLICT DO NOTHING;
      '''
    ];

    for (final query in queries) {
      try {
        await supabase.rpc('execute_raw_sql', params: {'query': query});
        print("Successfully executed query: $query");
      } catch (e) {
        print("Error executing query: $query, Error: $e");
      }
    }
  }
}
