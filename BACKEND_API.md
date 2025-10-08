# Bungalove Backend API Documentation (Planlanan)

> **Not**: Bu dokümantasyon gelecekte geliştirilecek backend API için hazırlanmış planlanan endpoint'leri içermektedir. Şu anda frontend uygulaması mock data ile çalışmaktadır.

## 🚧 Durum: Planlama Aşamasında
- ✅ API tasarımı tamamlandı
- ✅ Endpoint'ler belirlendi  
- ✅ Veri modelleri hazırlandı
- ⏳ Backend geliştirme bekleniyor
- ⏳ Database tasarımı bekleniyor

## Base URL (Planlanan)
```
https://api.bungalove.com/api/v1
```

## Authentication Endpoints

### 1. Login
**POST** `/auth/login`

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (200):**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresAt": "2024-01-15T10:30:00Z",
  "user": {
    "id": "1",
    "email": "user@example.com",
    "name": "John Doe",
    "phone": "+90 555 123 4567",
    "profileImage": "https://example.com/avatar.jpg",
    "role": "user",
    "createdAt": "2024-01-01T00:00:00Z",
    "isVerified": true
  }
}
```

**Response (401):**
```json
{
  "success": false,
  "error": "Invalid email or password"
}
```

### 2. Register
**POST** `/auth/register`

**Request Body:**
```json
{
  "email": "newuser@example.com",
  "password": "password123",
  "name": "New User",
  "phone": "+90 555 123 4567",
  "role": "user"
}
```

**Response (201):**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresAt": "2024-01-15T10:30:00Z",
  "user": {
    "id": "2",
    "email": "newuser@example.com",
    "name": "New User",
    "phone": "+90 555 123 4567",
    "profileImage": null,
    "role": "user",
    "createdAt": "2024-01-15T10:00:00Z",
    "isVerified": false
  }
}
```

### 3. Logout
**POST** `/auth/logout`

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

### 4. Validate Token
**GET** `/auth/validate`

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "valid": true,
  "user": {
    "id": "1",
    "email": "user@example.com",
    "name": "John Doe",
    "role": "user"
  }
}
```

### 5. Get Current User
**GET** `/auth/me`

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "id": "1",
  "email": "user@example.com",
  "name": "John Doe",
  "phone": "+90 555 123 4567",
  "profileImage": "https://example.com/avatar.jpg",
  "role": "user",
  "createdAt": "2024-01-01T00:00:00Z",
  "isVerified": true
}
```

### 6. Update Profile
**PUT** `/auth/profile`

**Headers:**
```
Authorization: Bearer <token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Updated Name",
  "phone": "+90 555 987 6543",
  "profileImage": "https://example.com/new-avatar.jpg"
}
```

**Response (200):**
```json
{
  "success": true,
  "user": {
    "id": "1",
    "email": "user@example.com",
    "name": "Updated Name",
    "phone": "+90 555 987 6543",
    "profileImage": "https://example.com/new-avatar.jpg",
    "role": "user",
    "createdAt": "2024-01-01T00:00:00Z",
    "isVerified": true
  }
}
```

### 7. Change Password
**PUT** `/auth/password`

**Headers:**
```
Authorization: Bearer <token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "currentPassword": "oldpassword",
  "newPassword": "newpassword123"
}
```

**Response (200):**
```json
{
  "success": true,
  "message": "Password changed successfully"
}
```

### 8. Forgot Password
**POST** `/auth/forgot-password`

**Request Body:**
```json
{
  "email": "user@example.com"
}
```

**Response (200):**
```json
{
  "success": true,
  "message": "Password reset email sent"
}
```

### 9. Reset Password
**POST** `/auth/reset-password`

**Request Body:**
```json
{
  "token": "reset-token-from-email",
  "newPassword": "newpassword123"
}
```

**Response (200):**
```json
{
  "success": true,
  "message": "Password reset successfully"
}
```

### 10. Refresh Token
**POST** `/auth/refresh`

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "token": "new-refreshed-token",
  "expiresAt": "2024-01-15T12:30:00Z"
}
```

## Error Responses

### 400 Bad Request
```json
{
  "success": false,
  "error": "Validation error",
  "details": {
    "email": ["Email is required"],
    "password": ["Password must be at least 6 characters"]
  }
}
```

### 401 Unauthorized
```json
{
  "success": false,
  "error": "Invalid or expired token"
}
```

### 403 Forbidden
```json
{
  "success": false,
  "error": "Insufficient permissions"
}
```

### 404 Not Found
```json
{
  "success": false,
  "error": "Resource not found"
}
```

### 500 Internal Server Error
```json
{
  "success": false,
  "error": "Internal server error"
}
```

## Security Considerations

1. **JWT Tokens**: Use JWT tokens for authentication with appropriate expiration times
2. **Password Hashing**: Use bcrypt or similar for password hashing
3. **HTTPS**: All endpoints should use HTTPS
4. **Rate Limiting**: Implement rate limiting for auth endpoints
5. **Input Validation**: Validate all input data
6. **CORS**: Configure CORS properly for web clients
7. **Token Refresh**: Implement automatic token refresh mechanism

## Database Schema

### Users Table
```sql
CREATE TABLE users (
  id VARCHAR(36) PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(20),
  profile_image VARCHAR(500),
  role ENUM('user', 'owner', 'admin') DEFAULT 'user',
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Refresh Tokens Table
```sql
CREATE TABLE refresh_tokens (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  token VARCHAR(500) NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

### Password Reset Tokens Table
```sql
CREATE TABLE password_reset_tokens (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  token VARCHAR(255) UNIQUE NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  used BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

## 🚀 Backend Geliştirme Planı

### **Faz 1: Temel Altyapı (4-6 hafta)**
- [ ] **Backend Framework** seçimi (Node.js/Express, Python/Django, Java/Spring)
- [ ] **Database** kurulumu (PostgreSQL, MongoDB)
- [ ] **Authentication** sistemi (JWT tokens)
- [ ] **Basic CRUD** operations
- [ ] **API Documentation** (Swagger/OpenAPI)

### **Faz 2: Core Features (6-8 hafta)**
- [ ] **User Management** endpoints
- [ ] **Property Listing** sistemi
- [ ] **Reservation** sistemi
- [ ] **File Upload** (resimler için)
- [ ] **Email** servisi (doğrulama, bildirimler)

### **Faz 3: Gelişmiş Özellikler (4-6 hafta)**
- [ ] **Search & Filter** algoritmaları
- [ ] **Real-time Chat** (WebSocket)
- [ ] **Payment Integration** (Stripe, PayPal)
- [ ] **Review & Rating** sistemi
- [ ] **Push Notifications**

### **Faz 4: Optimizasyon (2-4 hafta)**
- [ ] **Performance** optimizasyonu
- [ ] **Caching** stratejisi (Redis)
- [ ] **Load Balancing**
- [ ] **Security** audit
- [ ] **Monitoring** & Logging

## 🛠️ Teknoloji Seçenekleri

### **Backend Framework Seçenekleri:**
- **Node.js + Express** (JavaScript ecosystem)
- **Python + Django/FastAPI** (Hızlı geliştirme)
- **Java + Spring Boot** (Enterprise-grade)
- **Go + Gin** (Yüksek performans)

### **Database Seçenekleri:**
- **PostgreSQL** (Relational, ACID compliance)
- **MongoDB** (NoSQL, flexible schema)
- **MySQL** (Widely supported)
- **Firebase** (Real-time, easy setup)

### **Cloud Platform Seçenekleri:**
- **AWS** (EC2, RDS, S3)
- **Google Cloud** (Cloud Run, Firestore)
- **Azure** (App Service, SQL Database)
- **DigitalOcean** (Droplets, Managed Databases)

## 📊 Tahmini Maliyetler (Aylık)

### **Development Phase:**
- **Development Server**: $20-50
- **Database**: $15-30
- **Storage**: $5-15
- **Domain & SSL**: $10-20
- **Total**: ~$50-115/ay

### **Production Phase:**
- **Production Server**: $50-200
- **Database**: $30-100
- **CDN & Storage**: $20-50
- **Monitoring**: $10-30
- **Total**: ~$110-380/ay

## 🔗 Frontend Integration

Mevcut Flutter uygulaması bu API ile entegre edilecek:

```dart
// Örnek API çağrısı
final response = await http.post(
  Uri.parse('${EnvConfig.baseUrl}/auth/login'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'email': email,
    'password': password,
  }),
);
```

---

**Not**: Bu dokümantasyon backend geliştirme sürecinde güncellenecek ve gerçek endpoint'ler ile değiştirilecektir. 