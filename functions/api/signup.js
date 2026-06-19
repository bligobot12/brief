export async function onRequestPost({ request }) {
  let payload;
  try {
    payload = await request.json();
  } catch {
    return new Response(JSON.stringify({ error: 'invalid_json' }), {
      status: 400,
      headers: { 'content-type': 'application/json' },
    });
  }

  const email = typeof payload?.email === 'string' ? payload.email.trim() : '';
  const ok = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  if (!ok) {
    return new Response(JSON.stringify({ error: 'invalid_email' }), {
      status: 400,
      headers: { 'content-type': 'application/json' },
    });
  }

  console.log(JSON.stringify({
    event: 'brief_signup',
    email,
    ts: new Date().toISOString(),
    ip: request.headers.get('cf-connecting-ip') || null,
    ua: request.headers.get('user-agent') || null,
  }));

  return new Response(JSON.stringify({ ok: true }), {
    status: 200,
    headers: { 'content-type': 'application/json' },
  });
}

export function onRequest() {
  return new Response('Method Not Allowed', { status: 405 });
}
