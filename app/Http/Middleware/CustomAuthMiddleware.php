<?php

namespace App\Http\Middleware;

use Closure;

use App\Models\Tbl_AccessToken;

class CustomAuthMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $token = $request->header('Authorization');

        $check_token = Tbl_AccessToken::where('Token', $token)->first();

        if ($token && $check_token)
            return $next($request);
        else
            return response()->json('Unauthorizen', 401);
    }
}
