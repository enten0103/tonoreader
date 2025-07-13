import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/pages/auth/login/controller.dart';
import 'package:voidlord/routes/void_routers.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              // 标题部分
              _buildHeader(theme),
              const SizedBox(height: 48),

              // 表单部分
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildForm(controller, theme),
                ),
              ),

              const SizedBox(height: 24),

              // 底部操作区
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '欢迎回来',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '请登录您的账号',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(LoginController authController, ThemeData theme) {
    return Obx(() {
      final isLoading = authController.isLoading.value;

      return Column(
        children: [
          // 用户名输入框
          TextField(
            controller: controller.usernameController,
            decoration: InputDecoration(
              labelText: '用户名或邮箱',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),

          // 密码输入框
          TextField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '密码',
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),

          // 忘记密码
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.toNamed('/forgot_password'),
              child: Text(
                '忘记密码?',
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 登录按钮
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: isLoading ? null : () => _login(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      '登 录',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
            ),
          ),

          // 错误信息
          if (authController.errorMessage.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                authController.errorMessage.value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text('还没有账号?'),
          TextButton(
            onPressed: () => Get.toNamed(VoidRouters.registerPage),
            child: Text(
              '立即注册',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    final username = controller.usernameController.text.trim();

    final password = controller.passwordController.text.trim();

    if (username.isEmpty) {
      controller.errorMessage.value = '请输入用户名或邮箱';
      return;
    }

    if (password.isEmpty) {
      controller.errorMessage.value = '请输入密码';
      return;
    }

    try {
      await controller.login(username, password);
      Get.offNamed(VoidRouters.indexPage);
      Get.snackbar(
        '登录成功',
        '欢迎回来，$username',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {}
  }
}
