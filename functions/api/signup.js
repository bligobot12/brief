export async function onRequestPost({ request, env }) {
  let payload;
  try {
    payload = await request.json();
  } catch {
    return new Response(JSON.stringify({ error: 'invalid_json' }), {
      status: 400,
      headers: { 'content-type': 'application/json' },
    });
  }

  const email = typeof payload?.email === 'string'
    ? payload.email.trim().toLowerCase()
    : '';
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    return new Response(JSON.stringify({ error: 'invalid_email' }), {
      status: 400,
      headers: { 'content-type': 'application/json' },
    });
  }

  const sbRes = await fetch(`${env.SUPABASE_URL}/rest/v1/waitlist_emails`, {
    method: 'POST',
    headers: {
      'content-type': 'application/json',
      apikey: env.SUPABASE_SERVICE_ROLE_KEY,
      authorization: `Bearer ${env.SUPABASE_SERVICE_ROLE_KEY}`,
      Prefer: 'resolution=ignore-duplicates,return=minimal',
    },
    body: JSON.stringify({ email }),
  });

  if (!sbRes.ok) {
    const detail = await sbRes.text();
    console.error(JSON.stringify({
      event: 'brief_signup_supabase_error',
      status: sbRes.status,
      detail,
      ts: new Date().toISOString(),
    }));
    return new Response(JSON.stringify({ error: 'storage_failed' }), {
      status: 502,
      headers: { 'content-type': 'application/json' },
    });
  }

  console.log(JSON.stringify({
    event: 'brief_signup',
    status: sbRes.status,
    ts: new Date().toISOString(),
  }));

  return new Response(JSON.stringify({ ok: true }), {
    status: 200,
    headers: { 'content-type': 'application/json' },
  });
}

export function onRequest() {
  return new Response('Method Not Allowed', { status: 405 });
}
