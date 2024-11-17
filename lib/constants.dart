const backendUrl = String.fromEnvironment(
  'BACKEND_URL',
  defaultValue: "http://127.0.0.1:8000/api",
);

const rabbitmqUrl = String.fromEnvironment(
  "RABBITMQ_URL",
  defaultValue: "ws://127.0.0.1:61613/ws"
);
