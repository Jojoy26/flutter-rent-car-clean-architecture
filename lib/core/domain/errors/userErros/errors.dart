abstract class AuthException implements Exception{}

class LoginException extends AuthException{}
class SingUpException extends AuthException{}
class SingInByGoogleException extends AuthException{}
class GetCurrentUserException extends AuthException{}

class UserNotFound extends AuthException{}
class WrongPassword extends AuthException{}
class EmailAlreadyUse extends AuthException{}
class WeakPassword extends AuthException{}
class InvalidEmail extends AuthException{}
class NoInternetConnection extends AuthException{}
class UserRejectAuth extends AuthException{}



