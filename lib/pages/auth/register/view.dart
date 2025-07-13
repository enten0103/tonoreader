import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/exception/auth_exception.dart';
import 'package:voidlord/pages/auth/register/controller.dart';
import 'package:voidlord/routes/void_routers.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

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
                  child: _buildForm(theme),
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
          '创建账号',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '填写信息以注册新账号',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(ThemeData theme) {
    return Obx(() {
      final isLoading = controller.isLoading.value;
      final isRegistering = controller.isRegistering.value;

      return Column(
        children: [
          // 用户名输入框
          TextField(
            controller: controller.usernameController,
            decoration: InputDecoration(
              labelText: '用户名',
              hintText: '至少3个字符',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
          const SizedBox(height: 20),

          // 邮箱输入框
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: '电子邮箱',
              hintText: 'example@domain.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
          const SizedBox(height: 20),

          // 密码输入框
          TextField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '密码',
              hintText: '至少8个字符',
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
          const SizedBox(height: 20),

          // 确认密码输入框
          TextField(
            controller: controller.confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '确认密码',
              prefixIcon: const Icon(Icons.lock_reset_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),

          // 隐私政策同意
          Row(
            children: [
              Obx(() => Checkbox(
                    value: controller.agreeToTerms.value,
                    onChanged: (value) =>
                        controller.agreeToTerms.value = value!,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  )),
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text('我同意'),
                    TextButton(
                      onPressed: () => Get.toNamed('/terms'),
                      child: Text(
                        '服务条款',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Text('和'),
                    TextButton(
                      onPressed: () => Get.toNamed('/privacy'),
                      child: Text(
                        '隐私政策',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 错误信息
          if (controller.errorMessage.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                controller.errorMessage.value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),

          // 注册按钮
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed:
                  (isLoading && isRegistering) ? null : () => _register(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: (isLoading && isRegistering)
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      '注 册',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
          const Text('已有账号?'),
          TextButton(
            onPressed: () => Get.back(), // 返回到登录页面
            child: Text(
              '立即登录',
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

  Future<void> _register() async {
    final username = controller.usernameController.text.trim();
    final email = controller.emailController.text.trim();
    final password = controller.passwordController.text.trim();
    final confirmPassword = controller.confirmPasswordController.text.trim();

    if (username.isEmpty) {
      controller.errorMessage.value = '请输入用户名';
      return;
    }

    if (username.length < 3) {
      controller.errorMessage.value = '用户名至少需要3个字符';
      return;
    }

    if (email.isEmpty) {
      controller.errorMessage.value = '请输入电子邮箱';
      return;
    }

    if (!GetUtils.isEmail(email)) {
      controller.errorMessage.value = '请输入有效的电子邮箱';
      return;
    }

    if (password.isEmpty) {
      controller.errorMessage.value = '请输入密码';
      return;
    }

    if (password.length < 8) {
      controller.errorMessage.value = '密码至少需要8个字符';
      return;
    }

    if (password != confirmPassword) {
      controller.errorMessage.value = '两次输入的密码不一致';
      return;
    }

    if (!controller.agreeToTerms.value) {
      controller.errorMessage.value = '请同意服务条款和隐私政策';
      return;
    }

    try {
      await controller.register(username, email, password);
      Get.offAllNamed(VoidRouters.loginPage);
      Get.snackbar(
        '注册成功',
        '欢迎加入，$username',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (e is UserNameHasBeanUsedException) {
        controller.errorMessage.value = '用户名已被使用，请选择其他用户名';
      } else {
        controller.errorMessage.value = '注册失败，请稍后再试';
      }
    }
  }
}
