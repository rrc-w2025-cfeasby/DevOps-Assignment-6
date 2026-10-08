from app import app

def test_banking_route():
    client = app.test_client()
    response = client.get("/api/banking")
    assert response.status_code == 200
