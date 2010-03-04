# Build file automatically generated by ant2rake gem

require 'ant'
require 'fileutils'
require 'rbconfig'

@project = {
  :name => "pica-common",
  :default => "package",
  :basedir => "."
}
@properties = []
@environment = "env"
@properties['build.dir'] = "#{@properties['basedir']}/build"
@properties['dist.dir'] = "#{@properties['basedir']}/dist"
@properties['src.dir'] = "#{@properties['basedir']}/src"
@properties['gen.src.dir'] = "#{@properties['basedir']}/build/src"
@properties['build.classes.dir'] = "#{@properties['build.dir']}/classes"
@properties['build.test.classes.dir'] = "#{@properties['build.dir']}/test_classes"
@properties['build.functional.test.classes.dir'] = "#{@properties['build.dir']}/functional_test_classes"
@properties['unit-tests.dir'] = "#{@properties['basedir']}/unit-tests"
@properties['functional-tests.dir'] = "#{@properties['basedir']}/functional-tests"
@properties['functional-tests.dir'] = "#{@properties['basedir']}/functional-tests"
@properties['devlib.dir'] = "#{@properties['basedir']}/devlib"
@properties['unit.test.results.dir'] = "#{@properties['build.dir']}/unit-test-results"
@properties['functional.test.results.dir'] = "#{@properties['build.dir']}/functional-test-results"
@properties['build.lib.dir'] = "#{@properties['build.dir']}/lib"
@properties['conf.dir'] = "#{@properties['basedir']}/conf"
@properties['build.conf.dir'] = "#{@properties['build.dir']}/conf"
@properties['jarfile.name'] = "#{@properties['ant.project.name']}.jar"
@properties['jarfile.fullpath'] = @properties['build.dir}/${jarfile.name']
@properties['lib.dir'] = "#{@properties['basedir']}/lib"
@properties['project.compiletime.lib.dir'] = "#{@properties['lib.dir']}/compile-time"
@properties['project.runtime.lib.dir'] = "#{@properties['lib.dir']}/run-time"
@properties['pica.dependencies.lib.dir'] = "#{@properties['lib.dir']}/pica-dependencies"
@properties['test-utilities.dir'] = "#{@properties['basedir']}/test-utilities"
@properties['build.test.utilities.dir'] = "#{@properties['build.dir']}/test-utilities"
@properties['project.title'] = @properties['ant.project.name']
@properties['instrumented.classes.dir'] = "#{@properties['build.dir']}/instrumented_classes"
@properties['coverage.dir'] = "#{@properties['build.dir']}/coverage"
@properties['common.project.dir'] = "#{@properties['basedir']}/../pica-common"
@properties['common.devlib.dir'] = "#{@properties['common.project.dir']}/devlib"
@properties['common.resource.dir'] = "#{@properties['common.project.dir']}/resources"
@properties['zipfile.name'] = "#{@properties['build.dir']}/#{@properties['ant.project.name']}.zip"
@properties['base.zipincludes'] = "#{@properties['jarfile.name']},lib/*,conf/**/*"
@properties['deploy.script'] = "#{@properties['build.dir']}/deploy.rb"
@properties['build.key.fragment'] = "#{@properties['build.dir']}/build_key.rb"

=begin
<basename property='basedir.name' file='${basedir}'/>
=end
@properties['label'] = "LOCAL-BUILD"
@properties['projectname'] = @properties['ant.project.name']
@properties['cctimestamp'] = "now"
@properties['build.version'] = @properties['label']
@properties['base.cruise.prefix'] = "dashboard/tab/build/download/artifacts/#{@properties['projectname']}/log#{@properties['cctimestamp']}"
@properties['base.cruise.suffix'] = ".xml/acceptance-tests-report"

=begin
<path id='devlib.classpath'>
    <fileset dir='${devlib.dir}' includes='*.jar'/>
  </path>
=end

=begin
<path id='common.devlib.path'>
    <fileset dir='${common.devlib.dir}' includes='*.jar'/>
  </path>
=end

=begin
<path id='functional.test.classpath'/>
=end

=begin
<taskdef classpathref='common.devlib.path' resource='emma_ant.properties'/>
=end

desc "Set up common directory structures"
task :create_project_directories  do
FileUtils.mkdir_p @properties['project.compiletime.lib.dir']

FileUtils.mkdir_p @properties['project.runtime.lib.dir']

FileUtils.mkdir_p @properties['devlib.dir']


end


task :prepare  do
@properties['tests.exist'] = FileUtils.exists(@properties['unit-tests.dir'])
@properties['functional.tests.exist'] = FileUtils.exists(@properties['functional-tests.dir'])
@properties['compiletime.lib.dir.exists'] = FileUtils.exists(@properties['project.compiletime.lib.dir'])
@properties['runtime.lib.dir.exists'] = FileUtils.exists(@properties['project.runtime.lib.dir'])
@properties['test.utilities.exists'] = FileUtils.exists(@properties['test-utilities.dir'])
@properties['pica.dependencies.lib.dir.exists'] = FileUtils.exists(@properties['pica.dependencies.lib.dir'])
@properties['should.run.unit.test.reports'] = (not (Config::CONFIG['host_os'][/mswin/])) and (defined? @properties['tests.exist'])
@properties['should.run.functional.test.reports'] = (not (Config::CONFIG['host_os'][/mswin/])) and (defined? @properties['functional.tests.exist'])

end


desc "clean build artifacts"
task :clean => :prepare do
FileUtils.rm_rf @properties['build.dir']FileUtils.rm_rf @properties['dist.dir']
end

def build_and_gather_test (project_name, dest_dir=@properties['devlib.dir'], project_dir=@properties['basedir}/../@{project.name'], ant_file="@{project.dir}/build.xml", project_artifact="@{project.dir}/build/@{project.name}-test-utilities.jar")

=begin
<sequential>
      <ant dir='@{project.dir}' antfile='@{ant.file}' inheritall='false' target='jar-test-utilities'/>
      <copy todir='@{dest.dir}' file='@{project.artifact}'/>
    </sequential>
=end

end

def build_and_gather (project_name, dest_dir=@properties['pica.dependencies.lib.dir'], project_dir=@properties['basedir}/../@{project.name'], ant_file="@{project.dir}/build.xml", project_artifact="@{project.dir}/build/@{project.name}.jar")

=begin
<sequential>
      <ant dir='@{project.dir}' antfile='@{ant.file}' inheritall='false'>
        <property name='external.build' value='true'/>
      </ant>
      <copy todir='@{dest.dir}' file='@{project.artifact}'/>
    </sequential>
=end

end


=begin
<taskdef name='xjc' classname='com.sun.tools.xjc.XJCTask'>
    <classpath>
      <fileset dir='${common.devlib.dir}' includes='*.jar'/>
    </classpath>
  </taskdef>
=end

task :generate_jaxb_classes  do
FileUtils.mkdir_p @properties['gen.src.dir']


=begin
<xjc destDir='${gen.src.dir}' schema='${jaxb.schema}' package='${jaxb.package}'/>
=end

end


task :gather_dependencies  do
FileUtils.mkdir_p @properties['build.lib.dir']


end


task :gather_compiletime_jars  do

=begin
<copy failonerror='false' todir='${build.lib.dir}'>
      <fileset dir='${project.compiletime.lib.dir}'/>
    </copy>
=end

end


task :gather_runtime_jars  do

=begin
<copy failonerror='false' todir='${build.lib.dir}'>
      <fileset dir='${project.runtime.lib.dir}'/>
    </copy>
=end

end


task :gather_pica_jars  do

=begin
<copy failonerror='false' todir='${build.lib.dir}'>
      <fileset dir='${pica.dependencies.lib.dir}'/>
    </copy>
=end

end


task :gather_project_jars => [:gather_compiletime_jars, :gather_runtime_jars, :gather_pica_jars] do

end


task :compile => [:before_compile, :do_compile, :after_compile] do

end


task :before_compile  do

end


task :do_compile => [:prepare, :gather_dependencies, :gather_project_jars] do

=begin
<path id='compile.classpath'>
      <fileset dir='${build.lib.dir}' includes='*.jar,*.zip'/>
      <pathelement location='${build.classes.dir}'/>
    </path>
=end
FileUtils.mkdir_p @properties['build.classes.dir']


=begin
<javac srcdir='${src.dir}' destdir='${build.classes.dir}' classpathref='compile.classpath' debug='true' target='1.5'/>
=end

=begin
<copy todir='${build.classes.dir}'>
      <fileset dir='${src.dir}' includes='**/*.xml,**/*.properties,**/*.xsl,**/*.enc,**/*.key,**/*.sql'/>
    </copy>
=end

end


task :after_compile  do

end


task :before_compile_test  do

end


task :do_compile_test  do
FileUtils.mkdir_p @properties['build.test.classes.dir']


=begin
<path id='compile.test.classpath'>
      <path refid='devlib.classpath'/>
      <pathelement location='${build.classes.dir}'/>
      <path refid='compile.classpath'/>
      <pathelement location='${build.test.utilities.dir}'/>
    </path>
=end

=begin
<javac srcdir='${unit-tests.dir}' destdir='${build.test.classes.dir}' classpathref='compile.test.classpath' debug='true'/>
=end

=begin
<copy todir='${build.test.classes.dir}'>
      <fileset dir='${unit-tests.dir}' includes='**/*.xml'/>
    </copy>
=end

end


task :after_compile_test  do

end

@properties['emma.enabled'] = "true"

task :instrument_source => :compile do
FileUtils.mkdir_p @properties['instrumented.classes.dir']

FileUtils.mkdir_p @properties['coverage.dir']


=begin
<path id='instrumentation.path'>
      <pathelement location='${instrumented.classes.dir}'/>
      <path refid='common.devlib.path'/>
    </path>
=end

=begin
<emma enabled='${emma.enabled}'>
      <instr destdir='${instrumented.classes.dir}' metadatafile='${coverage.dir}/metadata.emma' instrpath='${build.classes.dir}'/>
    </emma>
=end

end


task :compile_test => [:instrument_source, :compile_test_utitilies, :before_compile_test, :do_compile_test, :after_compile_test] do

end


task :get_pica_test  do

=begin
<build-and-gather project.name='pica-test' dest.dir='${devlib.dir}'/>
=end

end


=begin
<path id='test.utilities.classpath'/>
=end

task :compile_test_utitilies => :compile do
FileUtils.mkdir_p @properties['build.test.utilities.dir']


=begin
<path id='compile.test.utilities.classpath'>
      <path refid='compile.classpath'/>
      <path refid='test.utilities.classpath'/>
      <path refid='devlib.classpath'/>
      <pathelement location='${build.classes.dir}'/>
    </path>
=end

=begin
<javac srcdir='${test-utilities.dir}' destdir='${build.test.utilities.dir}' classpathref='compile.test.utilities.classpath' target='1.5'/>
=end

end


task :get_dependent_test_utilities  do

end


task :jar_test_utilities => [:get_dependent_test_utilities, :compile_test_utitilies] do

=begin
<jar jarfile='${build.dir}/${ant.project.name}-test-utilities.jar' basedir='${build.test.utilities.dir}'/>
=end

end


task :gather_functional_dependencies  do

end


task :compile_functional_test => [:instrument_source, :gather_functional_dependencies, :jar_test_utilities] do
FileUtils.mkdir_p @properties['build.functional.test.classes.dir']


=begin
<path id='compile.functional.test.classpath'>
      <path refid='devlib.classpath'/>
      <pathelement location='${build.classes.dir}'/>
      <path refid='compile.classpath'/>
      <pathelement location='${build.test.utilities.dir}'/>
    </path>
=end

=begin
<javac srcdir='${functional-tests.dir}' destdir='${build.functional.test.classes.dir}' classpathref='compile.functional.test.classpath' target='1.5' debug='true'/>
=end

=begin
<copy todir='${build.functional.test.classes.dir}'>
      <fileset dir='${functional-tests.dir}' includes='**/*.xml,**/*.properties,**/*.xsl,**/*.enc,**/*.key,**/*.sql'/>

    </copy>
=end

end


task :run_unit_tests => :compile_test do
FileUtils.mkdir_p @properties['unit.test.results.dir']


=begin
<junit failureproperty='unit.tests.failed' fork='true' forkmode='once'>
      <assertions>
        <enable/>
      </assertions>
      <classpath id='run.test.classpath'>
        <path refid='instrumentation.path'/>
        <path refid='compile.test.classpath'/>
        <pathelement location='${build.test.classes.dir}'/>
        <pathelement location='${build.test.utilities.dir}'/>
      </classpath>

      <formatter type='xml'/>
      <batchtest todir='${unit.test.results.dir}'>
        <fileset dir='${build.test.classes.dir}' includes='**/*Tests.class'/>
      </batchtest>
      <jvmarg value='-Demma.coverage.out.file=${coverage.dir}/coverage.emma'/>
      <jvmarg value='-Demma.coverage.out.merge=true'/>
    </junit>
=end

end

def generate_junit_report (report_dir)

=begin
<sequential>
      <junitreport todir='@{report.dir}'>
        <fileset dir='@{report.dir}' includes='TEST-*.xml'/>
        <report todir='@{report.dir}'/>
      </junitreport>
    </sequential>
=end

end


task :generate_unit_test_report  do

=begin
<generate-junit-report report.dir='${unit.test.results.dir}'/>
=end

end


task :fail_if_tests_failed  do

=begin
<fail if='unit.tests.failed'/>
=end

end


task :unit_test_report => [:generate_unit_test_report, :fail_if_tests_failed] do

end


desc "run unit tests"
task :unit_test => [:clean, :run_unit_tests, :unit_test_report] do

end


task :before_functional_tests  do

end


task :run_functional_tests => [:compile_functional_test, :before_functional_tests] do
FileUtils.mkdir_p @properties['functional.test.results.dir']


=begin
<junit failureproperty='functional.tests.failed' fork='true' forkmode='once'>
      <assertions>
        <enable/>
      </assertions>
      <classpath id='run.test.classpath'>
        <path refid='instrumentation.path'/>
        <path refid='compile.classpath'/>
        <path refid='compile.functional.test.classpath'/>
        <pathelement location='${build.functional.test.classes.dir}'/>
        <path refid='functional.test.classpath'/>
      </classpath>

      <formatter type='xml'/>
      <batchtest todir='${functional.test.results.dir}'>
        <fileset dir='${build.functional.test.classes.dir}' includes='**/*Tests.class'/>
      </batchtest>
      <jvmarg value='-Demma.coverage.out.file=${coverage.dir}/coverage.emma'/>
      <jvmarg value='-Demma.coverage.out.merge=true'/>
    </junit>
=end

end


task :generate_functional_test_report  do

=begin
<generate-junit-report report.dir='${functional.test.results.dir}'/>
=end

end


task :fail_if_functional_tests_failed  do

=begin
<fail if='functional.tests.failed'/>
=end

end


task :functional_test_report => [:generate_functional_test_report, :fail_if_functional_tests_failed] do

end


desc "run functional tests"
task :functional_test => [:clean, :run_functional_tests, :functional_test_report] do

end


desc "run unit and functional tests"
task :all_tests => [:unit_test, :functional_test] do

end


task :capture_timestamp  do

=begin
<tstamp>
      <format property='build.time' pattern='MM/dd/yyyy HH:mm:ss'/>
    </tstamp>
=end

end


task :jar => [:unit_test, :capture_timestamp] do

=begin
<jar jarfile='${build.dir}/${ant.project.name}.jar' basedir='${build.classes.dir}'>
      <manifest>
        <attribute name='Implementation-Title' value='${project.title}'/>
        <attribute name='Implementation-Version' value='${build.version}'/>
      </manifest>
    </jar>
=end

end


task :executable_jar => [:unit_test, :capture_timestamp] do
FileUtils.mkdir_p @properties['conf.dir']


=begin
<copy todir='${build.conf.dir}'>
      <fileset dir='${conf.dir}'/>
    </copy>
=end

=begin
<path id='manifest.path'>
      <fileset dir='${build.lib.dir}'/>
      <path path='${build.conf.dir}'/>
      <pathelement path='../pica-libs/keys.jar'/>
    </path>
=end

=begin
<manifestclasspath property='manifest.classpath' jarfile='${jarfile.fullpath}'>
      <classpath refid='manifest.path'/>
    </manifestclasspath>
=end

=begin
<copy todir='${build.classes.dir}'>
      <fileset dir='${src.dir}' includes='**/*.xml'/>
    </copy>
=end

=begin
<jar jarfile='${jarfile.fullpath}' basedir='${build.classes.dir}'>
      <manifest>
        <attribute name='Implementation-Title' value='${project.title}'/>
        <attribute name='Implementation-Version' value='${build.version}'/>
        <attribute name='Class-Path' value='${manifest.classpath}'/>
        <attribute name='Main-Class' value='${main.class.name}'/>
      </manifest>
    </jar>
=end

end


task :cucumber => :gather_dependencies do
@properties['ruby.bin.dir'] = "#{@properties['lib.dir']}/jruby/bin"
FileUtils.mkdir_p @properties['build.dir']

@properties['fail.on.error'] = "true"

=begin
<exec failonerror='false' executable='${ruby.bin.dir}/cucumber' failifexecutionfails='true' resultproperty='acceptance.tests.failed'>
      <env path='${env.PATH}:${ruby.bin.dir}' key='PATH'/>
      <env value='-Xmx750m' key='JAVA_MEM'/>
      <arg value='--tags'/>
      <arg value='~@ignore'/>
      <arg value='-r'/>
      <arg value='lib/acceptance-tests.rb'/>
      <arg value='-r'/>
      <arg value='sprout_core'/>
      <arg value='-r'/>
      <arg value='features/step_definitions/policy_definitions.rb'/>
      <arg value='-f'/>
      <arg value='Pica::Formatter::SproutCore'/>
      <arg value='-o'/>
      <arg value='${build.dir}/report_data.js'/>
      <arg value='features'/>
    </exec>
=end
@properties['fail.the.build'] = 
=begin
<istrue value='${fail.on.error}'/>
=end
 and (not 
=begin
<equals arg1='0' arg2='${acceptance.tests.failed}'/>
=end
)

end


task :set_passing_cruise_path  do
@properties['cruise.path'] = "#{@properties['base.cruise.prefix']}L#{@properties['label']}#{@properties['base.cruise.suffix']}/"

end


task :set_failing_cruise_path  do
@properties['cruise.path'] = "#{@properties['base.cruise.prefix']}#{@properties['base.cruise.suffix']}/"

end


task :set_cruise_path => [:set_passing_cruise_path, :set_failing_cruise_path] do

end


task :acceptance_tests_report => [:cucumber, :set_cruise_path] do

=begin
<exec dir='${build.dir}' executable='rake'/>
=end

=begin
<move overwrite='yes' todir='${build.dir}/apps/reports/models' file='${build.dir}/report_data.js'/>
=end

=begin
<replace token='$CRUISE_PATH' value='${cruise.path}' file='${build.dir}/Buildfile'/>
=end

=begin
<exec dir='${build.dir}' executable='${ruby.bin.dir}/sc-build'>
      <env path='${env.PATH}:${ruby.bin.dir}' key='PATH'/>
    </exec>
=end

=begin
<move todir='${build.dir}/acceptance-tests-report'>
      <fileset dir='${build.dir}/tmp/build/${cruise.path}'/>
    </move>
=end

=begin
<fail if='fail.the.build'/>
=end

end


task :prepare_for_zip  do

end


task :create_project_fragment  do
FileUtils.mkdir_p @properties['build.dir']


=begin
<echo file='${build.key.fragment}' message='PROJECT_NAME = &quot;${basedir.name}&quot;&#xA;'/>
=end

end


task :create_build_key_fragment => :create_project_fragment do

=begin
<echo append='yes' file='${build.key.fragment}' message='BUILD_KEY = &quot;${cctimestamp}L${label}&quot;&#xA;&#xA;'/>
=end

end


task :create_deploy_script => :create_build_key_fragment do

=begin
<concat destfile='${deploy.script}'>
      <filelist>
        <file name='${common.resource.dir}/cruise_dist_zip.rb'/>
        <file name='${build.key.fragment}'/>
        <file name='${basedir}/deploy.rb'/>
      </filelist>
    </concat>
=end

end


task :dist_zip => [:executable_jar, :prepare_for_zip, :create_deploy_script] do
@properties['zip.includes'] = @properties['base.zipincludes']

=begin
<copy todir='${build.dir}'>
      <fileset dir='${basedir}' includes='${zip.includes}'/>
    </copy>
=end

=begin
<zip includes='${zip.includes}' basedir='${build.dir}' zipfile='${zipfile.name}'/>
=end

end


desc "Run code coverage reports"
task :emma_report => [:clean, :unit_test] do

=begin
<emma enabled='${emma.enabled}'>
      <report sourcepath='${src.dir}'>
        <fileset dir='${coverage.dir}' includes='*.emma'/>
        <html outfile='${coverage.dir}/coverage.html'/>
      </report>
    </emma>
=end

end


desc "Run code duplication report"
task :cpd_report  do

=begin
<taskdef name='cpd' classpathref='common.devlib.path' classname='net.sourceforge.pmd.cpd.CPDTask'/>
=end
@properties['cpd.dir'] = "#{@properties['build.dir']}/cpd"
@properties['cpd.xml.file'] = "#{@properties['cpd.dir']}/cpd.xml"
FileUtils.mkdir_p @properties['cpd.dir']


=begin
<cpd outputFile='${cpd.xml.file}' format='xml' encoding='UTF-8' ignoreLiterals='true' ignoreIdentifiers='true' minimumTokenCount='20'>
      <fileset dir='${src.dir}' includes='**/*.java'/>
    </cpd>
=end

=begin
<xslt out='${cpd.dir}/cpd.html' in='${cpd.xml.file}' style='${common.resource.dir}/cpdhtml.xslt'/>
=end

end

@properties['javancss.dir'] = "#{@properties['build.dir']}/javancss"
@properties['javancss.xml.file'] = "#{@properties['javancss.dir']}/javancss.xml"

desc "Run Code Complexity Report"
task :javancss_report  do

=begin
<taskdef name='javancss' classpathref='common.devlib.path' classname='javancss.JavancssAntTask'/>
=end
FileUtils.mkdir_p @properties['javancss.dir']


=begin
<javancss srcdir='${src.dir}' generatereport='true' format='xml' includes='**/*.java' abortonfail='false' outputfile='${javancss.xml.file}'/>
=end

=begin
<xslt out='${javancss.dir}/javancss.html' in='${javancss.xml.file}' style='${common.resource.dir}/wfncss.xsl'/>
=end

end

@properties['jdepend.dir'] = "#{@properties['build.dir']}/jdepend"
@properties['jdepend.xml.file'] = "#{@properties['jdepend.dir']}/jdepend.xml"
def jdepend_macro ()

=begin
<element name='excludes' optional='true'/>
=end

=begin
<sequential>
      <jdepend format='xml' outputfile='${jdepend.xml.file}'>
        <excludes/>
        <classespath>
          <pathelement location='${build.classes.dir}'/>
        </classespath>
      </jdepend>
    </sequential>
=end

end


desc "Run jdepend report"
task :jdepend_report => [:clean, :compile] do
FileUtils.mkdir_p @properties['jdepend.dir']


=begin
<jdepend-report/>
=end

=begin
<xslt out='${jdepend.dir}/jdepend.html' in='${jdepend.xml.file}' style='${common.resource.dir}/jdepend.xsl'/>
=end

end


task :reports => [:emma_report, :cpd_report, :javancss_report, :jdepend_report] do

end


task :package => [:clean, :jar] do

end

