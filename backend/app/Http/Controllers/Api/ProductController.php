<?php

namespace App\Http\Controllers\Api;

use App\Models\Product;
use Illuminate\Http\Request;
use App\Helpers\ResponseHelpers;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $products = Product::with('category')->when($request->status, function ($query, $status) {
            return $query->where('status', $status);
        })->get();
        return ResponseHelpers::jsonResponseHelper(data: $products, status: "success");
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /** 
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'category_id' => 'required|exists:categories,id',
            'name' => 'required',
            'price' => 'required',
            'criteria' => 'required',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048', // Validasi image
        ]);
    
        $product = new Product();
        $product->category_id = $request->category_id;
        $product->name = $request->name;
        $product->price = $request->price;
        $product->criteria = $request->criteria;
        $product->stock = 0;
    
        if ($request->hasFile('image')) {
        $image = $request->file('image');
        
        // 🔥 Ganti nama file dengan unik (pakai time + hash)
        $imageName = time() . '_' . uniqid() . '.' . $image->extension();
        
        // Simpan file ke storage
        $image->storeAs('public/products', $imageName);

        // Simpan URL endpoint untuk akses gambar
        $product->image = url('storage/products/' . $imageName);
        }

    
        $product->save();
        return ResponseHelpers::jsonResponseHelper(data: $product, status: "success");
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $product = Product::with('category')->find($id);
        
        if (!$product) {
            return response()->json([
                'status' => 'error',
                'message' => 'Product not found'
            ], 404);
        }
        return ResponseHelpers::jsonResponseHelper(data: $product, status: "success");
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $product = Product::find($id);

        if (!$product) {
            return response()->json(['status' => 'error', 'message' => 'Product not found'], 404);
        }

        if ($request->has('category_id')) $product->category_id = $request->category_id;
        if ($request->has('name')) $product->name = $request->name;
        if ($request->has('price')) $product->price = $request->price;
        if ($request->has('criteria')) $product->criteria = $request->criteria;
        if ($request->has('favorite')) $product->favorite = $request->favorite;

        if ($request->hasFile('image')) {
            if ($product->image) {
                $oldImagePath = str_replace(url('/'), '', $product->image);
                if (file_exists(public_path($oldImagePath))) {
                    unlink(public_path($oldImagePath));
                }
            }

            $image = $request->file('image');
            $imageName = time() . '_' . uniqid() . '.' . $image->extension();
            $image->storeAs('public/products', $imageName);
            $product->image = url('storage/products/' . $imageName);
        }

        $product->save();

        return ResponseHelpers::jsonResponseHelper(data: $product, status: "update success");
    }



    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $product = Product::find($id);
        if (!$product) {
            return response()->json(['status' => 'error', 'message' => 'Product not found'], 404);
        }

        $product->delete();
        return ResponseHelpers::jsonResponseHelper(data: $product, status: "delete success");
    }
}
