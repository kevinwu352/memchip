// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get confirm => '确定';

  @override
  String get cancel => '取消';

  @override
  String get http_error_unknown => '未知错误';

  @override
  String get http_error_network => '网络错误';

  @override
  String get http_error_status => '状态错误';

  @override
  String get http_error_decode => '解码错误';

  @override
  String get http_error_operation => '操作失败';

  @override
  String get http_success => '成功';

  @override
  String get login_title => '登录';

  @override
  String get login_subtitle => '永恒的回忆 温暖的陪伴';

  @override
  String get login_method_password => '密码登录';

  @override
  String get login_method_otp => '验证码登录';

  @override
  String get login_account_title => '账户';

  @override
  String get login_account_ph1 => '邮箱/手机号/用户名';

  @override
  String get login_account_ph2 => '邮箱/手机号';

  @override
  String get login_password_title => '密码';

  @override
  String get login_code_title => '验证码';

  @override
  String login_code_send_btn(num seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: ' ($seconds)',
      zero: '',
    );
    return '发送$_temp0';
  }

  @override
  String get login_submit_btn => '登录';

  @override
  String get login_register_btn => '注册';

  @override
  String get register_page_title => '注册';

  @override
  String get register_account_title => '账户';

  @override
  String get register_account_ph => '邮箱/手机号/用户名';

  @override
  String get register_code_title => '密码';

  @override
  String get register_confirm_title => '确认密码';

  @override
  String get register_submit_btn => '注册';

  @override
  String get about_page_title => '关于我们';

  @override
  String get about_line_license_title => '开源组件许可';

  @override
  String get about_line_term_title => '服务条款';

  @override
  String get about_line_privacy_title => '隐私政策';

  @override
  String get about_logout_btn => '退出';

  @override
  String about_version(Object version) {
    return '版本: $version';
  }

  @override
  String get home_nickname_empty => '用户昵称';

  @override
  String get home_phomail_empty => '暂无';

  @override
  String get home_section_title => '我的影像盒';

  @override
  String get home_empty_info => '暂无影像盒';

  @override
  String get home_new_btn => '新建影像盒';

  @override
  String get category_page_title => '影像盒分类';

  @override
  String get category_human_info => '用一张清晰的人像图片生成';

  @override
  String get category_human_btn => '创建人物影像盒';

  @override
  String get category_pet_info => '用一张宠物正面照和一张侧面照来生成';

  @override
  String get category_pet_btn => '创建宠物影像盒';

  @override
  String get create_page_title => '创建影像盒';

  @override
  String get create_image_title => '添加照片';

  @override
  String get create_image_library => '媒体库';

  @override
  String get create_image_camera => '相机';

  @override
  String get create_image_info_human => '请上传一张清晰的人像照片。';

  @override
  String get create_image_info_pet => '请上传一张宠物正面照片和一张侧面照片。';

  @override
  String get create_basic_title => '基本信息';

  @override
  String get create_name_title_human => '影像盒名称';

  @override
  String get create_name_ph_human => '请输入名称';

  @override
  String get create_name_title_pet => '宠物名';

  @override
  String get create_name_ph_pet => '请输入宠物名';

  @override
  String get create_gender_title => '性别';

  @override
  String get create_gender_male_human => '男';

  @override
  String get create_gender_female_human => '女';

  @override
  String get create_gender_male_pet => '男';

  @override
  String get create_gender_female_pet => '女';

  @override
  String get create_age_title => '年龄段';

  @override
  String get create_age_ph => '请选择年龄段';

  @override
  String get create_age_range1 => '儿童 (0-12)';

  @override
  String get create_age_range2 => '青少年 (13-17)';

  @override
  String get create_age_range3 => '青年 (18-35)';

  @override
  String get create_age_range4 => '中年 (36-59)';

  @override
  String get create_age_range5 => '都看 (60+)';

  @override
  String get create_figure_title => '身材类型';

  @override
  String get create_figure1 => '偏瘦';

  @override
  String get create_figure2 => '标准';

  @override
  String get create_figure3 => '健壮';

  @override
  String get create_figure4 => '丰满';

  @override
  String get create_species_title => '宠物各类';

  @override
  String get create_species_cat => '猫';

  @override
  String get create_species_dog => '狗';

  @override
  String get create_species_rabbit => '兔子';

  @override
  String get create_species_parrot => '鹦鹉';

  @override
  String get create_species_hamster => '仓鼠';

  @override
  String get create_species_other => '其它';

  @override
  String get create_tail_title => '尾巴';

  @override
  String get create_tail_yes => '有尾巴';

  @override
  String get create_tail_no => '无尾巴';

  @override
  String get create_personality_title => '性格';

  @override
  String get create_personality_playful => '活泼';

  @override
  String get create_personality_quiet => '安静';

  @override
  String get create_personality_foodie => '贪吃';

  @override
  String get create_personality_timid => '胆小';

  @override
  String get create_personality_clingy => '粘人';

  @override
  String get create_personality_solo => '独立';

  @override
  String get create_personality_naughty => '调皮';

  @override
  String get create_personality_tame => '乖巧';

  @override
  String get create_create_btn => '创建';

  @override
  String get detail_delete_alert_title => '警告';

  @override
  String get detail_delete_alert_info => '确定要删除这一项吗？';

  @override
  String get detail_activate_info => '目前没有已激活的角色';

  @override
  String get detail_activate_btn => '激活';

  @override
  String get detail_activate_alert_title => '输入序列号：';

  @override
  String get detail_preview_info => '目前没有预览图';

  @override
  String get detail_preview_btn => '生成预览图';

  @override
  String get detail_generate_title => '选择预览图';

  @override
  String get detail_generate_info => '请从下列图片中选择一张制作全息影像';

  @override
  String get detail_generate_btn => '生成全息影像';

  @override
  String get detail_generate_btn_ing => '生成中...';

  @override
  String get detail_generate_sel_title => '爱好';

  @override
  String get detail_generate_sel_info => '爱好（选择后会呈现相应的全息影像）';

  @override
  String get detail_generate_sel_btn => '确认选择';

  @override
  String get detail_generating_alert_title => '操作成功';

  @override
  String get detail_generating_alert_info => '角色正在生成中. 大概会花 4-5 分钟，请待会再来查看。';

  @override
  String get detail_generated_btn => '开始投射';
}
