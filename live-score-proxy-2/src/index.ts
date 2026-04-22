const apiBaseUrl = "https://webws.365scores.com/web";

const corsHeaders = {
	"Access-Control-Allow-Origin": "*",
	"Access-Control-Allow-Methods": "GET, OPTIONS",
	"Access-Control-Allow-Headers": "Content-Type",
};

export default {
	async fetch(request): Promise<Response> {
		if (request.method === "OPTIONS") {
			return new Response(null, {
				status: 204,
				headers: corsHeaders,
			});
		}

		if (request.method !== "GET") {
			return new Response("Method not allowed", {
				status: 405,
				headers: corsHeaders,
			});
		}

		try {
			const incomingUrl = new URL(request.url);
			const targetUrl = `${apiBaseUrl}${incomingUrl.pathname}${incomingUrl.search}`;

			const upstreamResponse = await fetch(targetUrl, {
				method: "GET",
				headers: {
					Accept: "application/json",
					"User-Agent": "live-score-proxy",
				},
			});

			const responseHeaders = new Headers(corsHeaders);
			const contentType = upstreamResponse.headers.get("content-type");
			if (contentType != null) {
				responseHeaders.set("Content-Type", contentType);
			}

			return new Response(upstreamResponse.body, {
				status: upstreamResponse.status,
				headers: responseHeaders,
			});
		} catch (error) {
			return Response.json(
				{
					error: "Proxy request failed",
					details:
						error instanceof Error ? error.message : "Unknown proxy error",
				},
				{
					status: 500,
					headers: corsHeaders,
				},
			);
		}
	},
} satisfies ExportedHandler<Env>;
