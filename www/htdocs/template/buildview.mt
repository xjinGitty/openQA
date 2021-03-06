? extends 'fluid'

? block locbar => sub {
?= super()
&gt; <a href="/results/">Results</a>
&gt; <?= $df ?>
&gt; <?= $options->{'build'} ?>
? }

? block content => sub {
<div class="grid_5 box box-shadow alpha" id="top_features_box">
	<div class="box-header aligncenter">
		Recent <?= $df ?> builds
	</div>
	<ul>
    <? for my $build (sort keys %$builds) { ?>
      <li style="<?= ($options->{'build'} eq 'Build'.$build)?'font-weight: bold;':'' ?>"><a href="/buildview/<?= $options->{'distri'} ?>/Build<?= $build ?>">Build<?= $build ?></a> (<?= $builds->{$build} ?>)</li>
    <? } ?>
	</ul>
</div>
<div class="grid_11 box box-shadow omega">
	<h2>Test result overview</h2>
	<p>This page lists the results for <b><?= $options->{'build'} ?></b> of <i><?= $df ?></i></p>
	<p />
	<table style="width: 95%;">
		<tr>
			<th>type<?= sortarrows('type') ?></th>
			<th>arch<?= sortarrows('arch') ?></th>
      <? for my $extra (@$extras) { ?>
			<th><?= $extra ?></th>
      <? } ?>
		</tr>
		<? cycle(1) ?>
		<? for my $test (@$resultlist) { ?>
		<tr class="<?= cycle() ?>">
			<td><?= $test->{'type'} ?></td>
			<td><?= $test->{'arch'} ?></td>
      <? for my $extra (@$extras) { ?>
      <? my $r = $test->{'results'}->{lc($extra)} || {'result' => 'n/a'} ?>
			<td><span class="result<?= lc($r->{'result'}) ?> textlink <?= ($r->{'result'} eq 'fail')?'tooltip':'' ?>" style="display: inline-block; width: 5em;">
        <? if ($r->{'result'} eq 'testing') { ?>
          <a href="/running/<?= $r->{'testname'} ?>"><?= $r->{'result'} ?></a>
        <? } elsif (!$readonly && $r->{'result'} eq 'missing') { ?>
          <a title="click to schedule" href="/schedule/<?= $r->{'testname'} ?>" onclick="this.href += '?redirect_back=1'" rel="nofollow"><?= $r->{'result'} ?></a>
        <? } elsif ($r->{'result'} eq 'OK') { ?>
          <a href="/results/<?= $r->{'testname'} ?>"><?= $r->{'result'} ?></a>
        <? } elsif ($r->{'result'} eq 'fail') { ?>
          <a href="/results/<?= $r->{'testname'} ?>">
            <?= $r->{'result'} ?>
            <span class="box box-shadow alpha">
              This tests did not succeed:<br />
              <? for my $ftest (keys %{$r->{'fails'}}) { ?>
                <span class="result<?= $res_css->{$r->{'fails'}->{$ftest}} ?>"><?= $ftest ?></span>
              <? } ?>
            </span>
          </a>
        <? } else { ?>
          <?= $r->{'result'} ?>
        <? } ?>
      </span></td>
      <? } ?>
		</tr>
		<? } ?>
	</table>
</div>
? } # endblock content
