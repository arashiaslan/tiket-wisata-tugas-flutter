<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class AuthController extends Controller
{
    public function login(Request $request){
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !password_verify($request->password, $user->password)) {
            return response([
                'status' => 'error',
                'message' => 'Invalid credentials'
            ], 401);
        }

        return response()->json([
            'token' => $user->createToken($user->email)->plainTextToken,
            'user' => $user
        ]);
    }

    public function logout(Request $request)
    {
        $user = $request->user();
        

        if (!$user) {
            return response()->json([
                'error' => 'User not authenticated.'
            ], 401);
        }

        // Pastikan token ada sebelum menghapusnya
        if ($user->currentAccessToken()) {
            $user->tokens()->delete();
            $user->currentAccessToken()->delete();

            return response()->json([
                'status' => 'success',
                'message' => 'Logout berhasil.'
            ], 200);
        }

        return response()->json([
            'status' => 'error',
            'message' => 'No active token found.'
        ], 400);
    }


}

