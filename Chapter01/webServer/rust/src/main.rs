use hyper::{
  server::conn::AddrStream,
  service::{make_service_fn, service_fn},
  Body, Request, Response, Server,
 };
 use std::convert::Infallible;

 #[tokio::main(worker_threads = 4)]
 async fn main() {
    let addr = ([0, 0, 0, 0], 8080).into();

    let make_svc = make_service_fn(|_socket: &AddrStream| async move {
       Ok::<_, Infallible>(service_fn(move |_: Request<Body>| async move {
             let hello = "Hello World!".to_string();
             Ok::<_, Infallible>(Response::new(Body::from(hello)))
       }))
    });

    let server = Server::bind(&addr).serve(make_svc);

    println!("Listening on http://{}", addr);
    if let Err(e) = server.await {
       eprintln!("server error: {}", e);
    }
 }
